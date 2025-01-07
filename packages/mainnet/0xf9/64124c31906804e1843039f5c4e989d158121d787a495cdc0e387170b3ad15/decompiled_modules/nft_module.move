module 0xf964124c31906804e1843039f5c4e989d158121d787a495cdc0e387170b3ad15::nft_module {
    struct Admin has key {
        id: 0x2::object::UID,
        enable_addresses: vector<address>,
        receive_address: address,
        pool: 0x2::coin::Coin<0x2::sui::SUI>,
        total_pool: u64,
    }

    struct Container has key {
        id: 0x2::object::UID,
        total_minted: u64,
        total_supply: u64,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        round_name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        total_supply: u64,
        whitelist: 0x2::object::ID,
        fee_for_mint: u64,
        is_public: bool,
        limit_minted: u64,
        total_minted: u64,
    }

    struct CreateRoundEvent has copy, drop {
        container_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        admin_address: address,
        round_name: 0x1::string::String,
        limit_minted: u64,
        start_time: u64,
        end_time: u64,
        total_supply: u64,
        fee_for_mint: u64,
        is_public: bool,
        whitelist: 0x2::object::ID,
    }

    struct CreateContainerEvent has copy, drop {
        container_id: 0x2::object::ID,
        total_supply: u64,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        index: u64,
    }

    struct NFT_MODULE has drop {
        dummy_field: bool,
    }

    struct MintNft has copy, drop {
        container_id: 0x2::object::ID,
        minter: address,
        round_id: 0x2::object::ID,
        price: u64,
        amount: u64,
        nft_ids: vector<0x2::object::ID>,
    }

    struct AdminMintNft has copy, drop {
        nft_ids: vector<0x2::object::ID>,
    }

    public entry fun add_whitelist(arg0: &mut Admin, arg1: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg4)) == true, 0);
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::add_whitelist(arg1, arg2, arg3, arg4);
    }

    public entry fun add_whitelist_with_bought(arg0: &mut Admin, arg1: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg5)) == true, 0);
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::add_whitelist_with_bought(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun admin_mint_nft(arg0: &mut Container, arg1: &mut Admin, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg1, 0x2::tx_context::sender(arg4)) == true, 0);
        assert!(arg0.total_supply > arg0.total_minted, 10);
        assert!(arg0.total_supply >= arg3, 10);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = arg0.total_minted;
        while (v0 < arg3) {
            let v3 = Nft{
                id    : 0x2::object::new(arg4),
                name  : 0x1::string::utf8(b"Shoshin NFT"),
                index : v2,
            };
            v2 = v2 + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<Nft>(&v3));
            0x2::transfer::public_transfer<Nft>(v3, arg2);
            v0 = v0 + 1;
        };
        let v4 = AdminMintNft{nft_ids: v1};
        0x2::event::emit<AdminMintNft>(v4);
        arg0.total_minted = arg0.total_minted + arg3;
    }

    public entry fun change_receive_address(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg0, 0x2::tx_context::sender(arg2));
        assert!(v0 == true, 0);
        arg0.receive_address = arg1;
    }

    public entry fun create_new_round(arg0: &mut Admin, arg1: &mut Container, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(isAdmin(arg0, v0) == true, 0);
        let v1 = 0x2::object::new(arg9);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::create_whitelist_conatiner(v2, arg9);
        let v4 = 0;
        if (arg7 == true) {
            v4 = arg8;
        };
        let v5 = Round{
            id           : v1,
            round_name   : arg2,
            start_time   : arg3,
            end_time     : arg4,
            total_supply : arg5,
            whitelist    : v3,
            fee_for_mint : arg6,
            is_public    : arg7,
            limit_minted : v4,
            total_minted : 0,
        };
        let v6 = CreateRoundEvent{
            container_id  : 0x2::object::id<Container>(arg1),
            round_id      : v2,
            admin_address : v0,
            round_name    : arg2,
            limit_minted  : v4,
            start_time    : arg3,
            end_time      : arg4,
            total_supply  : arg5,
            fee_for_mint  : arg6,
            is_public     : arg7,
            whitelist     : v3,
        };
        0x2::event::emit<CreateRoundEvent>(v6);
        0x2::dynamic_object_field::add<0x2::object::ID, Round>(&mut arg1.id, v3, v5);
    }

    public entry fun delete_wallet_address_in_whitelist(arg0: &mut Admin, arg1: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg3)) == true, 0);
        0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::delete_wallet_in_whitelist(arg1, arg2, arg3);
    }

    fun init(arg0: NFT_MODULE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Admin{
            id               : 0x2::object::new(arg1),
            enable_addresses : v1,
            receive_address  : v0,
            pool             : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1),
            total_pool       : 0,
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name} #{index}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"S0 is the NFT membership which launching by Shoshin Square. S0 is the key NFT to privilege, exclusive access at Shoshin ecosystem"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://shoshinsquare.infura-ipfs.io/ipfs/Qme9tCniCjJQk7BpNh63H79j7NDYZt2HsFLR9KUL1ZUtQV"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://shoshinsquare.com"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://shoshinsquare.infura-ipfs.io/ipfs/Qme9tCniCjJQk7BpNh63H79j7NDYZt2HsFLR9KUL1ZUtQV"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://shoshinsquare.infura-ipfs.io/ipfs/Qme9tCniCjJQk7BpNh63H79j7NDYZt2HsFLR9KUL1ZUtQV"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Shoshin Square"));
        let v7 = 0x2::package::claim<NFT_MODULE>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<Nft>(&v7, v3, v5, arg1);
        0x2::display::update_version<Nft>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Admin>(v2);
        let v9 = Container{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            total_supply : 5000,
        };
        0x2::transfer::share_object<Container>(v9);
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

    public entry fun mint_nft(arg0: &mut Container, arg1: &mut Admin, arg2: &mut 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::WhitelistContainer, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_supply > arg0.total_minted, 10);
        assert!(arg0.total_supply >= arg4, 10);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Round>(&mut arg0.id, 0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::get_id(arg2));
        assert!(0x2::clock::timestamp_ms(arg5) >= v1.start_time, 1);
        assert!(v1.total_supply >= arg4, 9);
        if (!v1.is_public && 0x2::clock::timestamp_ms(arg5) >= v1.end_time) {
            abort 3
        };
        if (v1.is_public == true) {
            if (0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::existed(arg2, v0) == true) {
                0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg2, arg4, v0, false, arg6);
            } else {
                let v2 = 0x1::vector::empty<address>();
                let v3 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<address>(&mut v2, v0);
                0x1::vector::push_back<u64>(&mut v3, v1.limit_minted);
                0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::add_whitelist(arg2, v2, v3, arg6);
                0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg2, arg4, v0, false, arg6);
            };
        } else {
            0x7d587bcdeea388c1ebac59054cd89ce7496139a655a23954567c7adcba305bca::whitelist_module::update_whitelist(arg2, arg4, v0, false, arg6);
        };
        let v4 = 0;
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = arg0.total_minted;
        while (v4 < arg4) {
            let v7 = Nft{
                id    : 0x2::object::new(arg6),
                name  : 0x1::string::utf8(b"S0 Membership"),
                index : v6,
            };
            v6 = v6 + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<Nft>(&v7));
            0x2::transfer::public_transfer<Nft>(v7, v0);
            v4 = v4 + 1;
        };
        let v8 = MintNft{
            container_id : 0x2::object::id<Container>(arg0),
            minter       : v0,
            round_id     : 0x2::object::id<Round>(v1),
            price        : v1.fee_for_mint,
            amount       : arg4,
            nft_ids      : v5,
        };
        0x2::event::emit<MintNft>(v8);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v1.fee_for_mint * arg4), arg6));
        arg1.total_pool = arg1.total_pool + v1.fee_for_mint * arg4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        v1.total_supply = v1.total_supply - arg4;
        v1.total_minted = v1.total_minted + arg4;
        arg0.total_minted = arg0.total_minted + arg4;
    }

    public entry fun transfer_nft(arg0: Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public entry fun withdraw(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg0, 0x2::tx_context::sender(arg2));
        assert!(v0 == true, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.pool), arg0.total_pool), arg2), arg1);
        arg0.total_pool = 0;
    }

    // decompiled from Move bytecode v6
}

