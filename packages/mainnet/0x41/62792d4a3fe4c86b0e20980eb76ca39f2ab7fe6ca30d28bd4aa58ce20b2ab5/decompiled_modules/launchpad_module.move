module 0x4162792d4a3fe4c86b0e20980eb76ca39f2ab7fe6ca30d28bd4aa58ce20b2ab5::launchpad_module {
    struct Admin has key {
        id: 0x2::object::UID,
        enable_addresses: vector<address>,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        is_public: bool,
        total_supply: u64,
        price: u64,
        limit_mint: u64,
        whitelist: 0x2::object::ID,
        status: bool,
        total_minted: u64,
    }

    struct Launchpad has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner_address: address,
        total_supply: u64,
        total_pool: u64,
        pool: 0x2::coin::Coin<0x2::sui::SUI>,
        total_minted: u64,
        is_deposit: bool,
        nft_container_ids: vector<0x2::object::ID>,
    }

    struct NFTContainer<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nfts: vector<T0>,
    }

    struct CreateLaunchpadEvent has copy, drop {
        project_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner_address: address,
        total_supply: u64,
        type: 0x1::type_name::TypeName,
        is_deposit: bool,
    }

    struct AddNftToProject has copy, drop {
        project_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct DelauchpadEvent has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        commission: u64,
        total_pool: u64,
    }

    struct BuyWithDepositNftEvent has copy, drop {
        project_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        price: u64,
        buyer: address,
        amount: u64,
        nft_ids: vector<0x2::object::ID>,
    }

    struct BuyWithMintNftEvent has copy, drop {
        project_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        price: u64,
        buyer: address,
        amount: u64,
    }

    struct CreateRoundEvent has copy, drop {
        project_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        name: 0x1::string::String,
        total_supply: u64,
        start_time: u64,
        end_time: u64,
        price: u64,
        is_public: bool,
        limit_mint: u64,
        whitelist: 0x2::object::ID,
    }

    struct CloseRoundEvent has copy, drop {
        project_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
    }

    public entry fun addAdmin(arg0: &mut Admin, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg0, 0x2::tx_context::sender(arg2));
        assert!(v0 == true, 0);
        0x1::vector::append<address>(&mut arg0.enable_addresses, arg1);
    }

    public entry fun add_whitelist(arg0: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg1: &mut Admin, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg1, 0x2::tx_context::sender(arg4)) == true, 0);
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::add_whitelist(arg0, arg2, arg3, arg4);
    }

    public entry fun delete_wallet_address_in_whitelist(arg0: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::delete_wallet_in_whitelist(arg0, arg1, arg2);
    }

    public fun deposit<T0: store + key>(arg0: &mut Launchpad, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 25);
        assert!(arg0.is_deposit == true, 26);
        let v0 = AddNftToProject{
            project_id : 0x2::object::id<Launchpad>(arg0),
            nft_id     : 0x2::object::id<T0>(&arg1),
        };
        0x2::event::emit<AddNftToProject>(v0);
        let v1 = arg0.nft_container_ids;
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NFTContainer<T0>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v1, 0x1::vector::length<0x2::object::ID>(&v1) - 1));
        if (0x1::vector::length<T0>(&v2.nfts) < 100) {
            0x1::vector::push_back<T0>(&mut v2.nfts, arg1);
        } else {
            let v3 = 0x1::vector::empty<T0>();
            0x1::vector::push_back<T0>(&mut v3, arg1);
            let v4 = NFTContainer<T0>{
                id   : 0x2::object::new(arg2),
                nfts : v3,
            };
            let v5 = 0x2::object::id<NFTContainer<T0>>(&v4);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.nft_container_ids, v5);
            0x2::dynamic_object_field::add<0x2::object::ID, NFTContainer<T0>>(&mut arg0.id, v5, v4);
        };
        arg0.total_supply = arg0.total_supply + 1;
    }

    public entry fun exist<T0: store + key>(arg0: &mut Admin, arg1: &mut Launchpad, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg4)) == true, 0);
        assert!(arg1.is_deposit == true, 25);
        assert!(arg1.total_supply > 0, 23);
        let v0 = arg1.nft_container_ids;
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NFTContainer<T0>>(&mut arg1.id, *0x1::vector::borrow<0x2::object::ID>(&v0, v1));
            if (0x1::vector::length<T0>(&v3.nfts) > 0) {
                0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v3.nfts), arg3);
                let v4 = v2 + 1;
                v2 = v4;
                if (v4 == arg2) {
                    break
                };
            };
            v1 = v1 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Admin{
            id               : 0x2::object::new(arg0),
            enable_addresses : v0,
        };
        0x2::transfer::share_object<Admin>(v1);
    }

    public fun isAdmin(arg0: &mut Admin, arg1: address) : bool {
        let v0 = false;
        let v1 = arg0.enable_addresses;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            if (*0x1::vector::borrow<address>(&v1, v2) == arg1) {
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun make_buy_deposit_nft<T0: store + key>(arg0: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg1: &mut Launchpad, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner_address != 0x2::tx_context::sender(arg6), 21);
        assert!(arg1.is_deposit == true, 25);
        assert!(arg1.total_supply > 0, 23);
        let v0 = arg1.nft_container_ids;
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NFTContainer<T0>>(&mut arg1.id, *0x1::vector::borrow<0x2::object::ID>(&v0, v1));
            while (v3 < arg4 && 0x1::vector::length<T0>(&v5.nfts) > 0) {
                let v6 = 0x1::vector::pop_back<T0>(&mut v5.nfts);
                0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<T0>(&v6));
                0x2::transfer::public_transfer<T0>(v6, 0x2::tx_context::sender(arg6));
                let v7 = v3 + 1;
                v3 = v7;
                if (v7 == arg4) {
                    v2 = true;
                    break
                };
            };
            if (v2 == true) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2 == true, 27);
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Round>(&mut arg1.id, arg2);
        assert!(v8.total_supply >= arg4, 23);
        assert!(v8.limit_mint == 0, 29);
        assert!(v8.status == true, 30);
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg0, arg4, 0x2::tx_context::sender(arg6), v8.is_public, arg6);
        let v9 = 0x2::clock::timestamp_ms(arg5);
        assert!(v9 > v8.start_time, 15);
        assert!(v9 < v8.end_time, 16);
        arg1.total_supply = arg1.total_supply - arg4;
        arg1.total_minted = arg1.total_minted + arg4;
        arg1.total_pool = arg1.total_pool + v8.price * arg4;
        v8.total_supply = v8.total_supply - arg4;
        v8.total_minted = v8.total_minted + arg4;
        let v10 = BuyWithDepositNftEvent{
            project_id : 0x2::object::id<Launchpad>(arg1),
            round_id   : 0x2::object::id<Round>(v8),
            price      : v8.price,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : arg4,
            nft_ids    : v4,
        };
        0x2::event::emit<BuyWithDepositNftEvent>(v10);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v8.price * arg4), arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg6));
    }

    public entry fun make_buy_mint_nft<T0: store + key>(arg0: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg1: &mut Launchpad, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner_address != 0x2::tx_context::sender(arg6), 21);
        assert!(arg1.is_deposit == false, 25);
        assert!(arg1.total_supply > 0, 23);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Round>(&mut arg1.id, arg2);
        assert!(v0.total_supply >= arg4, 23);
        assert!(v0.limit_mint == 0, 29);
        assert!(v0.status == true, 30);
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg0, arg4, 0x2::tx_context::sender(arg6), v0.is_public, arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 > v0.start_time, 15);
        assert!(v1 < v0.end_time, 16);
        let v2 = BuyWithMintNftEvent{
            project_id : 0x2::object::id<Launchpad>(arg1),
            round_id   : 0x2::object::id<Round>(v0),
            price      : v0.price,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : arg4,
        };
        0x2::event::emit<BuyWithMintNftEvent>(v2);
        arg1.total_supply = arg1.total_supply - arg4;
        arg1.total_minted = arg1.total_minted + arg4;
        arg1.total_pool = arg1.total_pool + v0.price * arg4;
        v0.total_supply = v0.total_supply - arg4;
        v0.total_minted = v0.total_minted + arg4;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v0.price * arg4), arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg6));
    }

    public entry fun make_buy_public_deposit_nft<T0: store + key>(arg0: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg1: &mut Launchpad, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner_address != 0x2::tx_context::sender(arg6), 21);
        assert!(arg1.is_deposit == true, 25);
        assert!(arg1.total_supply > 0, 23);
        let v0 = arg1.nft_container_ids;
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NFTContainer<T0>>(&mut arg1.id, *0x1::vector::borrow<0x2::object::ID>(&v0, v1));
            while (v3 < arg4 && 0x1::vector::length<T0>(&v5.nfts) > 0) {
                let v6 = 0x1::vector::pop_back<T0>(&mut v5.nfts);
                0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<T0>(&v6));
                0x2::transfer::public_transfer<T0>(v6, 0x2::tx_context::sender(arg6));
                let v7 = v3 + 1;
                v3 = v7;
                if (v7 == arg4) {
                    v2 = true;
                    break
                };
            };
            if (v2 == true) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2 == true, 27);
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Round>(&mut arg1.id, arg2);
        assert!(v8.total_supply >= arg4, 23);
        assert!(v8.limit_mint != 0, 28);
        assert!(v8.status == true, 30);
        if (0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::existed(arg0, 0x2::tx_context::sender(arg6)) == true) {
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg0, arg4, 0x2::tx_context::sender(arg6), false, arg6);
        } else {
            let v9 = 0x1::vector::empty<address>();
            let v10 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<address>(&mut v9, 0x2::tx_context::sender(arg6));
            0x1::vector::push_back<u64>(&mut v10, v8.limit_mint);
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::add_whitelist(arg0, v9, v10, arg6);
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg0, arg4, 0x2::tx_context::sender(arg6), false, arg6);
        };
        let v11 = 0x2::clock::timestamp_ms(arg5);
        assert!(v11 > v8.start_time, 15);
        assert!(v11 < v8.end_time, 16);
        arg1.total_supply = arg1.total_supply - arg4;
        arg1.total_minted = arg1.total_minted + arg4;
        arg1.total_pool = arg1.total_pool + v8.price * arg4;
        v8.total_supply = v8.total_supply - arg4;
        v8.total_minted = v8.total_minted + arg4;
        let v12 = BuyWithDepositNftEvent{
            project_id : 0x2::object::id<Launchpad>(arg1),
            round_id   : 0x2::object::id<Round>(v8),
            price      : v8.price,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : arg4,
            nft_ids    : v4,
        };
        0x2::event::emit<BuyWithDepositNftEvent>(v12);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v8.price * arg4), arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg6));
    }

    public entry fun make_buy_public_mint_nft<T0: store + key>(arg0: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg1: &mut Launchpad, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner_address != 0x2::tx_context::sender(arg6), 21);
        assert!(arg1.is_deposit == false, 25);
        assert!(arg1.total_supply > 0, 23);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Round>(&mut arg1.id, arg2);
        assert!(v0.total_supply >= arg4, 23);
        assert!(v0.status == true, 30);
        assert!(v0.limit_mint != 0, 28);
        if (0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::existed(arg0, 0x2::tx_context::sender(arg6)) == true) {
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg0, arg4, 0x2::tx_context::sender(arg6), false, arg6);
        } else {
            let v1 = 0x1::vector::empty<address>();
            let v2 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg6));
            0x1::vector::push_back<u64>(&mut v2, v0.limit_mint);
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::add_whitelist(arg0, v1, v2, arg6);
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg0, arg4, 0x2::tx_context::sender(arg6), false, arg6);
        };
        let v3 = 0x2::clock::timestamp_ms(arg5);
        assert!(v3 > v0.start_time, 15);
        assert!(v3 < v0.end_time, 16);
        let v4 = BuyWithMintNftEvent{
            project_id : 0x2::object::id<Launchpad>(arg1),
            round_id   : 0x2::object::id<Round>(v0),
            price      : v0.price,
            buyer      : 0x2::tx_context::sender(arg6),
            amount     : arg4,
        };
        0x2::event::emit<BuyWithMintNftEvent>(v4);
        arg1.total_supply = arg1.total_supply - arg4;
        arg1.total_supply = arg1.total_supply - arg4;
        arg1.total_minted = arg1.total_minted + arg4;
        arg1.total_pool = arg1.total_pool + v0.price * arg4;
        v0.total_supply = v0.total_supply - arg4;
        v0.total_minted = v0.total_minted + arg4;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v0.price * arg4), arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg6));
    }

    public entry fun make_close_round(arg0: &mut Launchpad, arg1: &mut Admin, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg1, 0x2::tx_context::sender(arg3)) == true, 0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Round>(&mut arg0.id, arg2);
        let v1 = CloseRoundEvent{
            project_id : 0x2::object::id<Launchpad>(arg0),
            round_id   : 0x2::object::id<Round>(v0),
        };
        0x2::event::emit<CloseRoundEvent>(v1);
        v0.status = false;
    }

    public entry fun make_create_launchpad<T0: store + key>(arg0: &mut Admin, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg5)) == true, 0);
        let v0 = arg3;
        if (arg4 == true) {
            v0 = 0;
        };
        let v1 = NFTContainer<T0>{
            id   : 0x2::object::new(arg5),
            nfts : 0x1::vector::empty<T0>(),
        };
        let v2 = 0x2::object::id<NFTContainer<T0>>(&v1);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, v2);
        let v4 = Launchpad{
            id                : 0x2::object::new(arg5),
            name              : arg1,
            owner_address     : arg2,
            total_supply      : v0,
            total_pool        : 0,
            pool              : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg5),
            total_minted      : 0,
            is_deposit        : arg4,
            nft_container_ids : v3,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, NFTContainer<T0>>(&mut v4.id, v2, v1);
        let v5 = CreateLaunchpadEvent{
            project_id    : 0x2::object::id<Launchpad>(&v4),
            name          : arg1,
            owner_address : arg2,
            total_supply  : v0,
            type          : 0x1::type_name::get<T0>(),
            is_deposit    : arg4,
        };
        0x2::event::emit<CreateLaunchpadEvent>(v5);
        0x2::transfer::share_object<Launchpad>(v4);
    }

    public entry fun make_create_round(arg0: &mut Launchpad, arg1: &mut Admin, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg1, 0x2::tx_context::sender(arg9)) == true, 0);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::create_whitelist_conatiner(v1, arg9);
        let v3 = 0;
        if (arg7 == true) {
            v3 = arg8;
        };
        let v4 = Round{
            id           : v0,
            name         : arg2,
            start_time   : arg4,
            end_time     : arg5,
            is_public    : arg7,
            total_supply : arg3,
            price        : arg6,
            limit_mint   : v3,
            whitelist    : v2,
            status       : true,
            total_minted : 0,
        };
        let v5 = CreateRoundEvent{
            project_id   : 0x2::object::id<Launchpad>(arg0),
            round_id     : v1,
            name         : arg2,
            total_supply : arg3,
            start_time   : arg4,
            end_time     : arg5,
            price        : arg6,
            is_public    : arg7,
            limit_mint   : v3,
            whitelist    : v2,
        };
        0x2::event::emit<CreateRoundEvent>(v5);
        0x2::dynamic_object_field::add<0x2::object::ID, Round>(&mut arg0.id, v1, v4);
    }

    public entry fun make_delaunchpad<T0: store + key>(arg0: &mut Launchpad, arg1: &mut Admin, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg1, 0x2::tx_context::sender(arg5));
        assert!(v0 == true, 0);
        withdraw(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = arg0.nft_container_ids;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, NFTContainer<T0>>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v1, v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<T0>(&v3.nfts)) {
                0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v3.nfts), arg4);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        arg0.total_supply = 0;
    }

    public entry fun make_deposit<T0: store + key>(arg0: &mut Launchpad, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg0, arg1, arg2);
    }

    public entry fun make_withdraw(arg0: &mut Launchpad, arg1: &mut Admin, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        withdraw(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun withdraw(arg0: &mut Launchpad, arg1: &mut Admin, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg1, 0x2::tx_context::sender(arg5)) == true, 0);
        let v0 = arg0.total_pool * arg2 / 100;
        let v1 = DelauchpadEvent{
            project_id : 0x2::object::id<Launchpad>(arg0),
            owner      : arg0.owner_address,
            commission : v0,
            total_pool : arg0.total_pool,
        };
        0x2::event::emit<DelauchpadEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.pool), arg0.total_pool - v0), arg5), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.pool), v0), arg5), arg3);
        arg0.total_pool = 0;
    }

    // decompiled from Move bytecode v6
}

