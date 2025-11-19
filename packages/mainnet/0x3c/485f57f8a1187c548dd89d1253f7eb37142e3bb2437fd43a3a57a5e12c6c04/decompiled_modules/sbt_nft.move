module 0x3c485f57f8a1187c548dd89d1253f7eb37142e3bb2437fd43a3a57a5e12c6c04::sbt_nft {
    struct ModuleState has key {
        id: 0x2::object::UID,
        paused: bool,
        collection_fee_amount: u64,
        fee_amount: u64,
        public_key: 0x1::string::String,
        deployer: address,
        minted_sbts: 0x2::table::Table<address, 0x2::table::Table<0x1::string::String, bool>>,
    }

    struct SBT_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        paused: bool,
        fee_amount: u64,
        deployer: address,
        sbtId: 0x1::string::String,
        minted_sbts: 0x2::table::Table<address, bool>,
        admins: 0x2::table::Table<address, bool>,
    }

    struct SBT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        sbtId: 0x1::string::String,
        collection_id: 0x2::object::ID,
        bound_to: address,
        transferable: bool,
    }

    struct Property has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct SBTMinted has copy, drop {
        sbt_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        recipient: address,
    }

    struct PausedStateChanged has copy, drop {
        paused: bool,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct OwnershipTransferred has copy, drop {
        from: address,
        to: address,
    }

    public fun add_collection_admin(arg0: &CollectionAdminCap, arg1: &mut Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        if (!0x2::table::contains<address, bool>(&arg1.admins, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.admins, arg2, true);
        };
    }

    public fun create_collection(arg0: &mut ModuleState, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg9);
        if (v0 > arg6) {
            assert!(v0 - arg6 < 900000, 6);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= arg0.collection_fee_amount, 3);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, arg1);
        0x1::string::append(&mut v2, arg2);
        0x1::string::append(&mut v2, arg3);
        0x1::string::append(&mut v2, 0x2::address::to_string(v1));
        0x1::string::append(&mut v2, arg4);
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg6));
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg7));
        let v3 = 0x2::hex::decode(0x1::string::into_bytes(arg0.public_key));
        let v4 = 0x2::hex::decode(0x1::string::into_bytes(arg5));
        assert!(0x2::ed25519::ed25519_verify(&v4, &v3, 0x1::string::as_bytes(&v2)), 2);
        if (arg0.collection_fee_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg8, arg0.collection_fee_amount, arg9), arg0.deployer);
            let v5 = FeeCollected{
                amount    : arg0.collection_fee_amount,
                recipient : arg0.deployer,
            };
            0x2::event::emit<FeeCollected>(v5);
        };
        let v6 = 0x2::object::new(arg9);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = 0x2::table::new<address, bool>(arg9);
        0x2::table::add<address, bool>(&mut v8, v1, true);
        if (arg0.deployer != v1) {
            0x2::table::add<address, bool>(&mut v8, arg0.deployer, true);
        };
        let v9 = Collection{
            id          : v6,
            name        : arg1,
            description : arg2,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg3)),
            paused      : false,
            fee_amount  : arg7,
            deployer    : v1,
            sbtId       : arg4,
            minted_sbts : 0x2::table::new<address, bool>(arg9),
            admins      : v8,
        };
        let v10 = CollectionCreated{
            collection_id : v7,
            name          : arg1,
            creator       : v1,
        };
        0x2::event::emit<CollectionCreated>(v10);
        let v11 = CollectionAdminCap{
            id            : 0x2::object::new(arg9),
            collection_id : v7,
        };
        0x2::transfer::share_object<Collection>(v9);
        0x2::transfer::public_transfer<CollectionAdminCap>(v11, arg0.deployer);
    }

    public fun get_fee_amount(arg0: &ModuleState) : u64 {
        arg0.fee_amount
    }

    public fun get_public_key(arg0: &ModuleState) : 0x1::string::String {
        arg0.public_key
    }

    public fun get_sbt_info(arg0: &SBT) : (0x1::string::String, 0x1::string::String, address, bool) {
        (arg0.name, arg0.description, arg0.bound_to, arg0.transferable)
    }

    public fun image_url(arg0: &SBT) : 0x1::string::String {
        0x1::string::from_ascii(0x2::url::inner_url(&arg0.url))
    }

    fun init(arg0: SBT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SBT_NFT>(arg0, arg1);
        let v1 = ModuleState{
            id                    : 0x2::object::new(arg1),
            paused                : false,
            collection_fee_amount : 100,
            fee_amount            : 0,
            public_key            : 0x1::string::utf8(b"f525fd50510dcc586692d84baea05cec40ed9cd24dd817481a6f5564d7c5283b"),
            deployer              : 0x2::tx_context::sender(arg1),
            minted_sbts           : 0x2::table::new<address, 0x2::table::Table<0x1::string::String, bool>>(arg1),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"sbt_id"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://tbook.com"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{sbtId}"));
        let v7 = 0x2::display::new_with_fields<SBT>(&v0, v3, v5, arg1);
        0x2::display::update_version<SBT>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ModuleState>(v1);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SBT>>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize_values(arg0: &AdminCap, arg1: &mut ModuleState, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.collection_fee_amount = arg2;
        arg1.fee_amount = arg3;
        arg1.public_key = arg4;
    }

    public fun is_collection_admin(arg0: &Collection, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    public fun is_paused(arg0: &ModuleState) : bool {
        arg0.paused
    }

    public fun is_transferable(arg0: &SBT) : bool {
        arg0.transferable
    }

    public fun mint(arg0: &mut ModuleState, arg1: &mut Collection, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        if (v1 > arg2) {
            assert!(v1 - arg2 < 900000, 6);
        };
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v2, 0x2::address::to_string(0x2::object::uid_to_address(&arg1.id)));
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg2));
        0x1::string::append(&mut v2, 0x2::address::to_string(v0));
        0x1::string::append(&mut v2, arg1.sbtId);
        let v3 = 0x2::hex::decode(0x1::string::into_bytes(arg0.public_key));
        let v4 = 0x2::hex::decode(0x1::string::into_bytes(arg3));
        assert!(0x2::ed25519::ed25519_verify(&v4, &v3, 0x1::string::as_bytes(&v2)), 2);
        assert!(!arg0.paused, 1);
        assert!(!arg1.paused, 1);
        assert!(!0x2::table::contains<address, bool>(&arg1.minted_sbts, v0), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= arg1.fee_amount, 3);
        if (arg1.fee_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, arg1.fee_amount, arg5), arg0.deployer);
            let v5 = FeeCollected{
                amount    : arg1.fee_amount,
                recipient : arg0.deployer,
            };
            0x2::event::emit<FeeCollected>(v5);
        };
        let v6 = SBT{
            id            : 0x2::object::new(arg5),
            name          : arg1.name,
            description   : arg1.description,
            url           : arg1.url,
            sbtId         : arg1.sbtId,
            collection_id : 0x2::object::uid_to_inner(&arg1.id),
            bound_to      : v0,
            transferable  : false,
        };
        let v7 = SBTMinted{
            sbt_id        : 0x2::object::id<SBT>(&v6),
            collection_id : 0x2::object::uid_to_inner(&arg1.id),
            recipient     : v0,
        };
        0x2::event::emit<SBTMinted>(v7);
        0x2::table::add<address, bool>(&mut arg1.minted_sbts, v0, true);
        0x2::transfer::transfer<SBT>(v6, v0);
    }

    public fun remove_collection_admin(arg0: &CollectionAdminCap, arg1: &mut Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 0);
        if (0x2::table::contains<address, bool>(&arg1.admins, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.admins, arg2);
        };
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut ModuleState, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = PausedStateChanged{paused: arg2};
        0x2::event::emit<PausedStateChanged>(v0);
    }

    public fun transfer_ownership(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnershipTransferred{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun update_collection_paused(arg0: &mut Collection, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admins, 0x2::tx_context::sender(arg2)), 0);
        arg0.paused = arg1;
    }

    public fun update_fee_amount(arg0: &AdminCap, arg1: &mut ModuleState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_amount = arg2;
    }

    public fun update_public_key(arg0: &AdminCap, arg1: &mut ModuleState, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.public_key = arg2;
    }

    public fun update_sbt_fee(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.admins, 0x2::tx_context::sender(arg2)), 0);
        arg0.fee_amount = arg1;
    }

    // decompiled from Move bytecode v6
}

