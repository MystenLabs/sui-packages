module 0x6b1d4105b64118134e6395e014f8981615c6da0e969d82621252a787453344f9::file_blob {
    struct FeeConfig has drop, store {
        contract_cost: u64,
        contract_fee: u64,
        wal_per_kb: u64,
        price_wal_to_sui_1000: u64,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        manager: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        feeConfig: FeeConfig,
        profile_map: 0x2::table::Table<address, Profile>,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        file_ids: vector<0x1::ascii::String>,
        vault_id: 0x1::ascii::String,
    }

    struct ProfileCreated has copy, drop {
        profile_address: address,
        vault_id: 0x1::ascii::String,
        sender: address,
    }

    struct FileData has copy, drop, store {
        vault_id: 0x1::ascii::String,
        file_id: 0x1::ascii::String,
        owner: address,
        mime_type: u8,
        size: u32,
    }

    struct FileAdded has copy, drop {
        file_data: FileData,
        cost: u64,
    }

    struct StroageCreated has copy, drop {
        storage: address,
    }

    entry fun add_file(arg0: &mut Storage, arg1: address, arg2: 0x1::ascii::String, arg3: u8, arg4: u32, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.manager == 0x2::tx_context::sender(arg5), 6);
        let v0 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profile_map, arg1);
        0x1::vector::push_back<0x1::ascii::String>(&mut v0.file_ids, arg2);
        let v1 = calcuate_fee(&arg0.feeConfig, (arg4 as u64));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v1));
        let v2 = FileData{
            vault_id  : v0.vault_id,
            file_id   : arg2,
            owner     : arg1,
            mime_type : arg3,
            size      : arg4,
        };
        let v3 = FileAdded{
            file_data : v2,
            cost      : v1,
        };
        0x2::event::emit<FileAdded>(v3);
    }

    public fun calcuate_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        arg0.contract_fee + arg0.contract_cost + (arg1 >> 10) * arg0.wal_per_kb * arg0.price_wal_to_sui_1000 / 1000
    }

    entry fun create_profile(arg0: &mut Storage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, Profile>(&arg0.profile_map, v0), 3);
        let v1 = Profile{
            id       : 0x2::object::new(arg3),
            owner    : v0,
            balance  : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            file_ids : 0x1::vector::empty<0x1::ascii::String>(),
            vault_id : arg2,
        };
        0x2::table::add<address, Profile>(&mut arg0.profile_map, v0, v1);
        let v2 = ProfileCreated{
            profile_address : 0x2::object::uid_to_address(&v1.id),
            vault_id        : arg2,
            sender          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProfileCreated>(v2);
    }

    fun create_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfig{
            contract_cost         : 1500000,
            contract_fee          : 1000000,
            wal_per_kb            : 150000,
            price_wal_to_sui_1000 : 172,
        };
        let v1 = Storage{
            id          : 0x2::object::new(arg0),
            manager     : 0x2::tx_context::sender(arg0),
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            feeConfig   : v0,
            profile_map : 0x2::table::new<address, Profile>(arg0),
        };
        let v2 = 0x2::object::id<Storage>(&v1);
        let v3 = StroageCreated{storage: 0x2::object::id_to_address(&v2)};
        0x2::event::emit<StroageCreated>(v3);
        0x2::transfer::share_object<Storage>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_storage(arg0);
    }

    public fun recharge(arg0: &mut Storage, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        let v0 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profile_map, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::value<0x2::sui::SUI>(&v0.balance)
    }

    entry fun try_get_profile(arg0: &Storage, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, Profile>(&arg0.profile_map, arg1)) {
            0x1::option::some<address>(0x2::object::uid_to_address(&0x2::table::borrow<address, Profile>(&arg0.profile_map, arg1).id))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun updateConfig(arg0: &mut Storage, arg1: u64) {
        arg0.feeConfig.contract_fee = arg1;
    }

    public fun updatePrice(arg0: &mut Storage, arg1: u64) {
        arg0.feeConfig.price_wal_to_sui_1000 = arg1;
    }

    entry fun withdraw(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.manager, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

