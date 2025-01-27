module 0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        public_key: vector<u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        collection_id: 0x1::string::String,
        mint_box: 0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::mint_box::MintBox,
        orders: 0x2::table::Table<0x1::string::String, u64>,
        supplies: 0x2::table::Table<0x1::string::String, u64>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CollectionOwnerCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x1::string::String,
    }

    struct Request has drop {
        sender: vector<u8>,
        nft_id: vector<u8>,
        edition_id: 0x1::string::String,
        collection_id: 0x1::string::String,
        order_id: 0x1::string::String,
        expire_at: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
        max_supply: u64,
        is_soulbound: bool,
        price: u64,
        fee: u64,
        recipient: vector<u8>,
    }

    struct CreateCollectionEvent has copy, drop {
        collection_id: 0x1::string::String,
    }

    struct FundCollectionEvent has copy, drop {
        collection_id: 0x1::string::String,
        funded: u64,
    }

    struct UpdateCollectionEvent has copy, drop {
        collection_id: 0x1::string::String,
    }

    struct LoadMintBoxEvent has copy, drop {
        collection_id: 0x1::string::String,
        marker: u64,
    }

    struct MintOrderEvent has copy, drop {
        collection_id: 0x1::string::String,
        order_id: 0x1::string::String,
        nft_hash: u256,
    }

    struct MintNftEvent has copy, drop {
        collection_id: 0x1::string::String,
        order_id: 0x1::string::String,
        nft_id: 0x2::object::ID,
        price: u64,
    }

    struct UpdateNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    entry fun create_collection(arg0: &Manager, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x1::string::utf8(0x1::vector::empty<u8>()) == 0x1::string::utf8(b""), 42);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Request{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            nft_id           : 0x1::vector::empty<u8>(),
            edition_id       : 0x1::string::utf8(0x1::vector::empty<u8>()),
            collection_id    : arg1,
            order_id         : 0x1::string::utf8(0x1::vector::empty<u8>()),
            expire_at        : 0,
            name             : 0x1::string::utf8(0x1::vector::empty<u8>()),
            description      : 0x1::string::utf8(0x1::vector::empty<u8>()),
            media_url        : 0x1::string::utf8(0x1::vector::empty<u8>()),
            attribute_keys   : 0x1::vector::empty<0x1::string::String>(),
            attribute_values : 0x1::vector::empty<0x1::string::String>(),
            max_supply       : 0,
            is_soulbound     : false,
            price            : 0,
            fee              : 0,
            recipient        : 0x2::bcs::to_bytes<address>(&v1),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg2, arg0.public_key, &v2);
        let v3 = Collection{
            id            : 0x2::object::new(arg3),
            collection_id : arg1,
            mint_box      : 0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::mint_box::new(arg3),
            orders        : 0x2::table::new<0x1::string::String, u64>(arg3),
            supplies      : 0x2::table::new<0x1::string::String, u64>(arg3),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = CollectionOwnerCap{
            id            : 0x2::object::new(arg3),
            collection_id : arg1,
        };
        let v5 = CreateCollectionEvent{collection_id: arg1};
        0x2::event::emit<CreateCollectionEvent>(v5);
        0x2::transfer::public_transfer<CollectionOwnerCap>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_share_object<Collection>(v3);
    }

    entry fun fund_collection(arg0: &Manager, arg1: &Collection, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Request{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            nft_id           : 0x1::vector::empty<u8>(),
            edition_id       : 0x1::string::utf8(0x1::vector::empty<u8>()),
            collection_id    : arg1.collection_id,
            order_id         : 0x1::string::utf8(0x1::vector::empty<u8>()),
            expire_at        : 0,
            name             : 0x1::string::utf8(0x1::vector::empty<u8>()),
            description      : 0x1::string::utf8(0x1::vector::empty<u8>()),
            media_url        : 0x1::string::utf8(0x1::vector::empty<u8>()),
            attribute_keys   : 0x1::vector::empty<0x1::string::String>(),
            attribute_values : 0x1::vector::empty<0x1::string::String>(),
            max_supply       : 0,
            is_soulbound     : false,
            price            : 0,
            fee              : arg2,
            recipient        : 0x2::bcs::to_bytes<address>(&v1),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg3, arg0.public_key, &v2);
        let v3 = FundCollectionEvent{
            collection_id : arg1.collection_id,
            funded        : arg2,
        };
        0x2::event::emit<FundCollectionEvent>(v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg2, 4);
        0x2::pay::keep<0x2::sui::SUI>(arg4, arg5);
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LAUNCHPAD>(arg0, arg1);
        let v0 = Manager{
            id         : 0x2::object::new(arg1),
            version    : 0,
            admin      : 0x2::tx_context::sender(arg1),
            public_key : 0x1::vector::empty<u8>(),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    entry fun load_mint_box(arg0: &Manager, arg1: &mut Collection, arg2: u64, arg3: vector<u256>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_admin_and_version(arg0, arg4);
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::mint_box::load(&mut arg1.mint_box, arg2, arg3, arg4);
        let v0 = LoadMintBoxEvent{
            collection_id : arg1.collection_id,
            marker        : arg2,
        };
        0x2::event::emit<LoadMintBoxEvent>(v0);
    }

    public fun mint_edition_nft<T0: store + key>(arg0: &mut Manager, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::clock::Clock, arg3: &mut Collection, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: 0x2::coin::Coin<0x2::sui::SUI>, arg17: T0, arg18: &mut 0x2::kiosk::Kiosk, arg19: &0x2::kiosk::KioskOwnerCap, arg20: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg20);
        let v1 = 0x2::tx_context::sender(arg20);
        let v2 = Request{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            nft_id           : 0x1::vector::empty<u8>(),
            edition_id       : arg4,
            collection_id    : arg3.collection_id,
            order_id         : arg5,
            expire_at        : arg6,
            name             : arg7,
            description      : arg8,
            media_url        : arg9,
            attribute_keys   : arg10,
            attribute_values : arg11,
            max_supply       : arg14,
            is_soulbound     : false,
            price            : arg12,
            fee              : arg13,
            recipient        : 0x2::bcs::to_bytes<address>(&v1),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg15, arg0.public_key, &v2);
        upsert_order(arg3, arg5, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg6 * 1000, 3);
        upsert_supply(arg3, arg4, arg14);
        let v3 = MintNftEvent{
            collection_id : arg3.collection_id,
            order_id      : arg5,
            nft_id        : 0x2::object::id<T0>(&arg17),
            price         : arg12 + arg13,
        };
        0x2::event::emit<MintNftEvent>(v3);
        0x2::kiosk::lock<T0>(arg18, arg19, arg1, arg17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg16) == arg12 + arg13, 4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, arg16);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::take<0x2::sui::SUI>(&mut arg3.balance, arg13, arg20));
    }

    public fun mint_nft<T0: store + key>(arg0: &Manager, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut Collection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: vector<u8>, arg15: T0, arg16: &mut 0x2::tx_context::TxContext) {
        verify_admin_and_version(arg0, arg16);
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = Request{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            nft_id           : 0x1::vector::empty<u8>(),
            edition_id       : arg3,
            collection_id    : arg2.collection_id,
            order_id         : arg4,
            expire_at        : 0,
            name             : arg5,
            description      : arg6,
            media_url        : arg7,
            attribute_keys   : arg8,
            attribute_values : arg9,
            max_supply       : arg12,
            is_soulbound     : false,
            price            : arg10,
            fee              : arg11,
            recipient        : 0x2::bcs::to_bytes<address>(&arg13),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg14, arg0.public_key, &v1);
        upsert_order(arg2, arg4, 1);
        if (arg12 > 0) {
            upsert_supply(arg2, arg3, arg12);
        };
        let v2 = MintNftEvent{
            collection_id : arg2.collection_id,
            order_id      : arg4,
            nft_id        : 0x2::object::id<T0>(&arg15),
            price         : arg10 + arg11,
        };
        0x2::event::emit<MintNftEvent>(v2);
        let (v3, v4) = 0x2::kiosk::new(arg16);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::lock<T0>(&mut v6, &v5, arg1, arg15);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, arg13);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
    }

    public fun mint_order(arg0: &mut Manager, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut Collection, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = Request{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            nft_id           : 0x1::vector::empty<u8>(),
            edition_id       : 0x1::string::utf8(0x1::vector::empty<u8>()),
            collection_id    : arg3.collection_id,
            order_id         : arg4,
            expire_at        : arg5,
            name             : 0x1::string::utf8(0x1::vector::empty<u8>()),
            description      : 0x1::string::utf8(0x1::vector::empty<u8>()),
            media_url        : 0x1::string::utf8(0x1::vector::empty<u8>()),
            attribute_keys   : 0x1::vector::empty<0x1::string::String>(),
            attribute_values : 0x1::vector::empty<0x1::string::String>(),
            max_supply       : 0,
            is_soulbound     : false,
            price            : arg6,
            fee              : arg7,
            recipient        : 0x2::bcs::to_bytes<address>(&v1),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg8, arg0.public_key, &v2);
        upsert_order(arg3, arg4, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg5 * 1000, 3);
        let v3 = MintOrderEvent{
            collection_id : arg3.collection_id,
            order_id      : arg4,
            nft_hash      : 0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::mint_box::get(&mut arg3.mint_box, arg1, arg10),
        };
        0x2::event::emit<MintOrderEvent>(v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) == arg6 + arg7, 4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, arg9);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::take<0x2::sui::SUI>(&mut arg3.balance, arg7, arg10));
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_admin_and_version(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_public_key(arg0: &mut Manager, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        verify_admin_and_version(arg0, arg2);
        arg0.public_key = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    entry fun update_collection<T0: store + key>(arg0: &Manager, arg1: &CollectionOwnerCap, arg2: &mut 0x2::display::Display<T0>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>) {
        verify_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::display::remove<T0>(arg2, *0x1::vector::borrow<0x1::string::String>(&arg3, v0));
            v0 = v0 + 1;
        };
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 5);
        v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x2::display::add<T0>(arg2, *0x1::vector::borrow<0x1::string::String>(&arg4, v0), *0x1::vector::borrow<0x1::string::String>(&arg5, v0));
            v0 = v0 + 1;
        };
        let v1 = UpdateCollectionEvent{collection_id: arg1.collection_id};
        0x2::event::emit<UpdateCollectionEvent>(v1);
    }

    entry fun update_collection_royalty<T0: store + key, T1: drop, T2: drop + store>(arg0: &Manager, arg1: &CollectionOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &0x2::transfer_policy::TransferPolicyCap<T0>, arg4: u16) {
        verify_version(arg0);
        if (0x2::transfer_policy::has_rule<T0, T1>(arg2)) {
            0x2::transfer_policy::remove_rule<T0, T1, T2>(arg2, arg3);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T0>(arg2, arg3, arg4, 0);
        let v0 = UpdateCollectionEvent{collection_id: arg1.collection_id};
        0x2::event::emit<UpdateCollectionEvent>(v0);
    }

    public fun update_nft(arg0: &mut Manager, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = Request{
            sender           : 0x2::bcs::to_bytes<address>(&v0),
            nft_id           : 0x2::object::id_to_bytes(&arg1),
            edition_id       : 0x1::string::utf8(0x1::vector::empty<u8>()),
            collection_id    : 0x1::string::utf8(0x1::vector::empty<u8>()),
            order_id         : 0x1::string::utf8(0x1::vector::empty<u8>()),
            expire_at        : 0,
            name             : arg2,
            description      : arg3,
            media_url        : arg4,
            attribute_keys   : arg5,
            attribute_values : arg6,
            max_supply       : 0,
            is_soulbound     : false,
            price            : 0,
            fee              : 0,
            recipient        : 0x2::bcs::to_bytes<address>(&v1),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg7, arg0.public_key, &v2);
        let v3 = UpdateNftEvent{nft_id: arg1};
        0x2::event::emit<UpdateNftEvent>(v3);
    }

    fun upsert_order(arg0: &mut Collection, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.orders, arg1)) {
            assert!(*0x2::table::borrow<0x1::string::String, u64>(&arg0.orders, arg1) < arg2, 3);
            0x2::table::remove<0x1::string::String, u64>(&mut arg0.orders, arg1);
        };
        0x2::table::add<0x1::string::String, u64>(&mut arg0.orders, arg1, arg2);
    }

    fun upsert_supply(arg0: &mut Collection, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.supplies, arg1)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.supplies, arg1, 0);
        };
        let v0 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.supplies, arg1);
        assert!(v0 < arg2, 6);
        0x2::table::add<0x1::string::String, u64>(&mut arg0.supplies, arg1, v0 + 1);
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
    }

    fun verify_admin_and_version(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg1);
        verify_version(arg0);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 0, 2);
    }

    entry fun withdraw_balance(arg0: &mut Manager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_admin_and_version(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1)
        };
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg2);
        };
    }

    entry fun withdraw_collection_balance(arg0: &Manager, arg1: &mut Collection, arg2: &CollectionOwnerCap, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(arg1.collection_id == arg2.collection_id, 1);
        let v0 = if (arg3 == 0) {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg3)
        };
        if (0x2::tx_context::sender(arg5) == arg4) {
            0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg4);
        };
    }

    entry fun withdraw_collection_royalty<T0: store + key>(arg0: &Manager, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::transfer_policy::TransferPolicyCap<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = if (arg3 == 0) {
            0x2::transfer_policy::withdraw<T0>(arg1, arg2, 0x1::option::none<u64>(), arg5)
        } else {
            0x2::transfer_policy::withdraw<T0>(arg1, arg2, 0x1::option::some<u64>(arg3), arg5)
        };
        if (0x2::tx_context::sender(arg5) == arg4) {
            0x2::pay::keep<0x2::sui::SUI>(v0, arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

