module 0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::airdrop {
    struct Airdrop has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>,
        is_enabled: bool,
        start_time: u64,
        duration: u64,
    }

    struct Quest has store, key {
        id: 0x2::object::UID,
    }

    struct Quest2 has store, key {
        id: 0x2::object::UID,
    }

    struct DevAirdrop has store, key {
        id: 0x2::object::UID,
    }

    struct VendettaAirdropNFT has key {
        id: 0x2::object::UID,
        allocated_amount: u64,
        name: 0x1::string::String,
        type_name: 0x1::type_name::TypeName,
        image_url: 0x1::string::String,
        balance: 0x2::balance::Balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>,
        start: u64,
        claimed: u64,
        duration: u64,
    }

    struct Allocation has store, key {
        id: 0x2::object::UID,
        collaboration: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        holder_allocation: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        total_claimed: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        total_distributed: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        vesting_status: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        holders: 0x2::table::Table<address, vector<0x1::type_name::TypeName>>,
        total_allocation: u64,
        total_airdropped: u64,
        claimed_count: u64,
    }

    struct AirdropEnabled has copy, drop {
        is_enabled: bool,
    }

    struct FundsAdded has copy, drop {
        total_funds: u64,
    }

    struct AIRDROP has drop {
        dummy_field: bool,
    }

    public fun claim(arg0: &Airdrop, arg1: &mut VendettaAirdropNFT, arg2: &mut Allocation, arg3: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA> {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg3, 1);
        assert!(arg0.is_enabled, 2);
        let v0 = claimable(arg1, arg4);
        arg1.claimed = arg1.claimed + v0;
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg2.total_claimed, arg1.type_name);
        *v1 = *v1 + v0;
        arg2.claimed_count = arg2.claimed_count + v0;
        0x2::coin::from_balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(0x2::balance::split<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&mut arg1.balance, v0), arg5)
    }

    public fun add_funds_for_airdrop(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Airdrop, arg2: 0x2::coin::Coin<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>, arg3: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg3, 1);
        0x2::balance::join<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&mut arg1.balance, 0x2::coin::into_balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(arg2));
        let v0 = FundsAdded{total_funds: 0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg1.balance)};
        0x2::event::emit<FundsAdded>(v0);
    }

    public fun add_vesting_time_for_airdrop(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Airdrop, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg5, 1);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg2), 9);
        arg1.start_time = arg3;
        arg1.duration = arg4;
    }

    public fun airdrop_nft_for_collection<T0>(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Airdrop, arg2: &mut Allocation, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<address>, arg6: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg6, 1);
        assert!(arg1.is_enabled, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg2.collaboration, v0), 6);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg2.holder_allocation, v0);
        assert!(*v1 * 0x1::vector::length<address>(&arg5) <= 0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg1.balance), 5);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg2.total_distributed, v0);
        assert!(*v2 + *v1 * 0x1::vector::length<address>(&arg5) <= *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg2.collaboration, v0), 7);
        *v2 = *v2 + *v1 * 0x1::vector::length<address>(&arg5);
        let v3 = 0;
        let v4 = 0;
        if (*0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg2.vesting_status, v0)) {
            v3 = arg1.duration;
            v4 = arg1.start_time;
        };
        arg2.total_airdropped = arg2.total_airdropped + *v1 * 0x1::vector::length<address>(&arg5);
        0x1::vector::reverse<address>(&mut arg5);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg5)) {
            let v6 = 0x1::vector::pop_back<address>(&mut arg5);
            if (0x2::table::contains<address, vector<0x1::type_name::TypeName>>(&arg2.holders, v6)) {
                let v7 = 0x2::table::borrow_mut<address, vector<0x1::type_name::TypeName>>(&mut arg2.holders, v6);
                assert!(!0x1::vector::contains<0x1::type_name::TypeName>(v7, &v0), 8);
                0x1::vector::push_back<0x1::type_name::TypeName>(v7, v0);
            } else {
                let v8 = 0x1::vector::empty<0x1::type_name::TypeName>();
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v8, v0);
                0x2::table::add<address, vector<0x1::type_name::TypeName>>(&mut arg2.holders, v6, v8);
            };
            let v9 = VendettaAirdropNFT{
                id               : 0x2::object::new(arg7),
                allocated_amount : *v1,
                name             : arg3,
                type_name        : v0,
                image_url        : arg4,
                balance          : 0x2::balance::split<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&mut arg1.balance, *v1),
                start            : v4,
                claimed          : 0,
                duration         : v3,
            };
            0x2::transfer::transfer<VendettaAirdropNFT>(v9, v6);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<address>(arg5);
    }

    public fun airdrop_nft_for_quest<T0>(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Airdrop, arg2: &mut Allocation, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<address>, arg6: vector<u64>, arg7: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg7, 1);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 10);
        assert!(arg1.is_enabled, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg2.collaboration, v0), 6);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg2.total_distributed, v0);
        let v2 = 0;
        let v3 = 0;
        if (*0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg2.vesting_status, v0)) {
            v2 = arg1.duration;
            v3 = arg1.start_time;
        };
        let v4 = 0;
        let v5 = 0;
        while (v4 < 0x1::vector::length<address>(&arg5)) {
            assert!(*0x1::vector::borrow<u64>(&arg6, v4) > 0, 3);
            if (0x2::table::contains<address, vector<0x1::type_name::TypeName>>(&arg2.holders, *0x1::vector::borrow<address>(&arg5, v4))) {
                let v6 = 0x2::table::borrow_mut<address, vector<0x1::type_name::TypeName>>(&mut arg2.holders, *0x1::vector::borrow<address>(&arg5, v4));
                assert!(!0x1::vector::contains<0x1::type_name::TypeName>(v6, &v0), 8);
                0x1::vector::push_back<0x1::type_name::TypeName>(v6, v0);
            } else {
                let v7 = 0x1::vector::empty<0x1::type_name::TypeName>();
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v7, v0);
                0x2::table::add<address, vector<0x1::type_name::TypeName>>(&mut arg2.holders, *0x1::vector::borrow<address>(&arg5, v4), v7);
            };
            let v8 = VendettaAirdropNFT{
                id               : 0x2::object::new(arg8),
                allocated_amount : *0x1::vector::borrow<u64>(&arg6, v4),
                name             : arg3,
                type_name        : v0,
                image_url        : arg4,
                balance          : 0x2::balance::split<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&mut arg1.balance, *0x1::vector::borrow<u64>(&arg6, v4)),
                start            : v3,
                claimed          : 0,
                duration         : v2,
            };
            0x2::transfer::transfer<VendettaAirdropNFT>(v8, *0x1::vector::borrow<address>(&arg5, v4));
            v5 = v5 + *0x1::vector::borrow<u64>(&arg6, v4);
            v4 = v4 + 1;
        };
        assert!(v5 <= 0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg1.balance), 5);
        assert!(*v1 + v5 <= *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg2.collaboration, v0), 7);
        *v1 = *v1 + v5;
    }

    public fun allocate_amount<T0>(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &Airdrop, arg2: &mut Allocation, arg3: u64, arg4: u64, arg5: bool, arg6: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg6, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg3 > 0 && arg4 > 0, 3);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg2.collaboration, v0), 4);
        assert!(arg2.total_allocation + arg4 <= 0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg1.balance), 5);
        assert!(arg3 <= arg4, 3);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg2.collaboration, v0, arg4);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg2.total_claimed, v0, 0);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg2.total_distributed, v0, 0);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg2.holder_allocation, v0, arg3);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg2.vesting_status, v0, arg5);
        arg2.total_allocation = arg2.total_allocation + arg4;
    }

    public fun claimable(arg0: &VendettaAirdropNFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start) {
            return 0
        };
        if (v0 >= arg0.start + arg0.duration) {
            return 0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg0.balance)
        };
        ((((0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg0.balance) + arg0.claimed) as u128) * ((v0 - arg0.start) as u128) / (arg0.duration as u128)) as u64) - arg0.claimed
    }

    public fun enable_airdrop(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Airdrop, arg2: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg2, 1);
        assert!(arg1.start_time != 0 && arg1.duration != 0, 1);
        arg1.is_enabled = true;
        let v0 = AirdropEnabled{is_enabled: arg1.is_enabled};
        0x2::event::emit<AirdropEnabled>(v0);
    }

    public fun get_address_details(arg0: address, arg1: &Allocation) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        if (0x2::table::contains<address, vector<0x1::type_name::TypeName>>(&arg1.holders, arg0)) {
            v0 = *0x2::table::borrow<address, vector<0x1::type_name::TypeName>>(&arg1.holders, arg0);
        };
        v0
    }

    public fun get_airdrop_balance(arg0: &Airdrop) : u64 {
        0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg0.balance)
    }

    public fun get_allocation_for_nft_type(arg0: 0x1::type_name::TypeName, arg1: &Allocation) : (u64, u64, u64, u64) {
        (*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.collaboration, arg0), *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.total_claimed, arg0), *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.total_distributed, arg0), *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.holder_allocation, arg0))
    }

    public fun get_total_airdropped(arg0: &Allocation) : u64 {
        arg0.total_airdropped
    }

    public fun get_total_allocation(arg0: &Allocation) : u64 {
        arg0.total_allocation
    }

    public fun get_total_claimed_count(arg0: &Allocation) : u64 {
        arg0.claimed_count
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AIRDROP>(arg0, arg1);
        let v1 = 0x2::display::new<VendettaAirdropNFT>(&v0, arg1);
        0x2::display::add<VendettaAirdropNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Vendetta Airdrop NFT"));
        0x2::display::add<VendettaAirdropNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The Airdrop NFT for Vendetta"));
        0x2::display::add<VendettaAirdropNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<VendettaAirdropNFT>(&mut v1);
        let v2 = Airdrop{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::balance::zero<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(),
            is_enabled : false,
            start_time : 0,
            duration   : 0,
        };
        let v3 = Allocation{
            id                : 0x2::object::new(arg1),
            collaboration     : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            holder_allocation : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            total_claimed     : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            total_distributed : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            vesting_status    : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            holders           : 0x2::table::new<address, vector<0x1::type_name::TypeName>>(arg1),
            total_allocation  : 0,
            total_airdropped  : 0,
            claimed_count     : 0,
        };
        0x2::transfer::share_object<Airdrop>(v2);
        0x2::transfer::share_object<Allocation>(v3);
        let v4 = DevAirdrop{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DevAirdrop>(v4);
        let v5 = Quest{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Quest>(v5);
        let v6 = Quest2{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Quest2>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VendettaAirdropNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

