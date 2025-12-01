module 0x410803f65eea1f248bdd6ce3b407d08943c71b6b9e1f4bce41738f66fcff0c17::traceCollection {
    struct TRACECOLLECTION has drop {
        dummy_field: bool,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
        current_supply: u64,
        creator: address,
        admins: vector<address>,
        transfer_policy_id: 0x1::option::Option<0x2::object::ID>,
        is_paused: bool,
        created_at: u64,
    }

    struct TraceNFT has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        metadata_url: 0x1::string::String,
        minted_at: u64,
        minted_by: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        timestamp: u64,
    }

    struct CollectionUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        updated_by: address,
        timestamp: u64,
    }

    struct CollectionPaused has copy, drop {
        collection_id: 0x2::object::ID,
        paused_by: address,
        timestamp: u64,
    }

    struct CollectionUnpaused has copy, drop {
        collection_id: 0x2::object::ID,
        unpaused_by: address,
        timestamp: u64,
    }

    struct MaxSupplyUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        old_max_supply: u64,
        new_max_supply: u64,
        updated_by: address,
        timestamp: u64,
    }

    struct TransferPolicySet has copy, drop {
        collection_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        set_by: address,
        timestamp: u64,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct NFTMinted has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        token_id: u64,
        recipient: address,
        recipient_kiosk: 0x2::object::ID,
        minted_by: address,
        timestamp: u64,
    }

    struct NFTBurned has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        token_id: u64,
        burned_by: address,
        timestamp: u64,
    }

    struct NFTPlacedInKiosk has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct NFTLocked has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminAdded has copy, drop {
        collection_id: 0x2::object::ID,
        admin: address,
        added_by: address,
        timestamp: u64,
    }

    struct AdminRemoved has copy, drop {
        collection_id: 0x2::object::ID,
        admin: address,
        removed_by: address,
        timestamp: u64,
    }

    public entry fun add_admin(arg0: &mut Collection, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x1::vector::length<address>(&arg0.admins) < 10, 10);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v0 = AdminAdded{
                collection_id : 0x2::object::uid_to_inner(&arg0.id),
                admin         : arg1,
                added_by      : 0x2::tx_context::sender(arg3),
                timestamp     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<AdminAdded>(v0);
        };
    }

    public entry fun burn_nft(arg0: TraceNFT, arg1: &mut Collection, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg3)), 0);
        assert!(arg0.collection_id == 0x2::object::uid_to_inner(&arg1.id), 17);
        let TraceNFT {
            id            : v0,
            collection_id : _,
            token_id      : _,
            name          : _,
            description   : _,
            image_url     : _,
            attributes    : v6,
            metadata_url  : _,
            minted_at     : _,
            minted_by     : _,
        } = arg0;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v6);
        0x2::object::delete(v0);
        let v10 = NFTBurned{
            collection_id : 0x2::object::uid_to_inner(&arg1.id),
            nft_id        : 0x2::object::uid_to_inner(&arg0.id),
            token_id      : arg0.token_id,
            burned_by     : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NFTBurned>(v10);
    }

    public entry fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0 && 0x1::string::length(&arg0) <= 100, 12);
        assert!(0x1::string::length(&arg1) <= 500, 13);
        assert!(0x1::string::length(&arg2) <= 200, 14);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Collection{
            id                 : 0x2::object::new(arg4),
            name               : arg0,
            description        : arg1,
            image_url          : arg2,
            max_supply         : 18446744073709551615,
            current_supply     : 0,
            creator            : v0,
            admins             : v1,
            transfer_policy_id : 0x1::option::none<0x2::object::ID>(),
            is_paused          : false,
            created_at         : 0x2::clock::timestamp_ms(arg3),
        };
        let v3 = CollectionCreated{
            collection_id : 0x2::object::uid_to_inner(&v2.id),
            name          : v2.name,
            creator       : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CollectionCreated>(v3);
        0x2::transfer::share_object<Collection>(v2);
    }

    public entry fun create_kiosk(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = KioskCreated{
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            owner     : v3,
            timestamp : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<KioskCreated>(v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, v3);
    }

    public entry fun create_transfer_policy(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<TraceNFT>(arg0, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TraceNFT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TraceNFT>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun get_collection_info(arg0: &Collection) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, bool) {
        (arg0.name, arg0.description, arg0.image_url, arg0.max_supply, arg0.current_supply, arg0.is_paused)
    }

    public fun get_nft_info(arg0: &TraceNFT) : (0x2::object::ID, u64, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64) {
        (arg0.collection_id, arg0.token_id, arg0.name, arg0.description, arg0.image_url, arg0.metadata_url, arg0.minted_at)
    }

    public fun get_transfer_policy_id(arg0: &Collection) : 0x1::option::Option<0x2::object::ID> {
        arg0.transfer_policy_id
    }

    fun init(arg0: TRACECOLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TRACECOLLECTION>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.trace.fan/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.trace.fan"));
        let v5 = 0x2::display::new_with_fields<TraceNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<TraceNFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://app.trace.fan/collections/{id}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://app.trace.fan"));
        let v10 = 0x2::display::new_with_fields<Collection>(&v0, v6, v8, arg1);
        0x2::display::update_version<Collection>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TraceNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(v10, 0x2::tx_context::sender(arg1));
    }

    fun is_admin(arg0: &Collection, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_collection_admin(arg0: &Collection, arg1: address) : bool {
        is_admin(arg0, arg1)
    }

    public entry fun mint_to_kiosk(arg0: &mut Collection, arg1: address, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<TraceNFT>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg12)), 0);
        assert!(!arg0.is_paused, 15);
        assert!(arg0.current_supply < arg0.max_supply, 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg9) == 0x1::vector::length<0x1::string::String>(&arg10), 2);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.transfer_policy_id)) {
            assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<TraceNFT>>(arg4) == *0x1::option::borrow<0x2::object::ID>(&arg0.transfer_policy_id), 11);
        };
        let v0 = arg0.current_supply + 1;
        let v1 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg12);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"collection_name"), arg0.name);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg9)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg9, v2);
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg10, v2);
            assert!(v3 != 0x1::string::utf8(b"collection_name"), 6);
            if (0x1::string::length(&v3) > 0 && 0x1::string::length(&v4) > 0) {
                assert!(!0x2::table::contains<0x1::string::String, 0x1::string::String>(&v1, v3), 7);
                0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v1, v3, v4);
            };
            v2 = v2 + 1;
        };
        let v5 = TraceNFT{
            id            : 0x2::object::new(arg12),
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            token_id      : v0,
            name          : arg5,
            description   : arg6,
            image_url     : arg7,
            attributes    : v1,
            metadata_url  : arg8,
            minted_at     : 0x2::clock::timestamp_ms(arg11),
            minted_by     : 0x2::tx_context::sender(arg12),
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        let v7 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v8 = 0x2::clock::timestamp_ms(arg11);
        arg0.current_supply = arg0.current_supply + 1;
        let v9 = NFTMinted{
            collection_id   : 0x2::object::uid_to_inner(&arg0.id),
            nft_id          : v6,
            token_id        : v0,
            recipient       : arg1,
            recipient_kiosk : v7,
            minted_by       : 0x2::tx_context::sender(arg12),
            timestamp       : v8,
        };
        0x2::event::emit<NFTMinted>(v9);
        0x2::kiosk::lock<TraceNFT>(arg2, arg3, arg4, v5);
        let v10 = NFTPlacedInKiosk{
            nft_id    : v6,
            kiosk_id  : v7,
            owner     : arg1,
            timestamp : v8,
        };
        0x2::event::emit<NFTPlacedInKiosk>(v10);
        let v11 = NFTLocked{
            nft_id    : v6,
            kiosk_id  : v7,
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<TraceNFT>>(arg4),
            timestamp : v8,
        };
        0x2::event::emit<NFTLocked>(v11);
    }

    public entry fun pause_collection(arg0: &mut Collection, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.is_paused = true;
        let v0 = CollectionPaused{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            paused_by     : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CollectionPaused>(v0);
    }

    public entry fun remove_admin(arg0: &mut Collection, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 8);
        assert!(arg1 != 0x2::tx_context::sender(arg3), 9);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.admins, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        if (v1) {
            let v2 = AdminRemoved{
                collection_id : 0x2::object::uid_to_inner(&arg0.id),
                admin         : arg1,
                removed_by    : 0x2::tx_context::sender(arg3),
                timestamp     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<AdminRemoved>(v2);
        };
    }

    public entry fun set_transfer_policy(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<TraceNFT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<TraceNFT>>(arg1);
        arg0.transfer_policy_id = 0x1::option::some<0x2::object::ID>(v0);
        let v1 = TransferPolicySet{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            policy_id     : v0,
            set_by        : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransferPolicySet>(v1);
    }

    public entry fun unpause_collection(arg0: &mut Collection, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.is_paused = false;
        let v0 = CollectionUnpaused{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            unpaused_by   : 0x2::tx_context::sender(arg2),
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CollectionUnpaused>(v0);
    }

    public entry fun update_collection_info(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg5)), 0);
        if (0x1::string::length(&arg1) > 0) {
            assert!(0x1::string::length(&arg1) <= 100, 12);
            arg0.name = arg1;
        };
        if (0x1::string::length(&arg2) > 0) {
            assert!(0x1::string::length(&arg2) <= 500, 13);
            arg0.description = arg2;
        };
        if (0x1::string::length(&arg3) > 0) {
            assert!(0x1::string::length(&arg3) <= 200, 14);
            arg0.image_url = arg3;
        };
        let v0 = CollectionUpdated{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            updated_by    : 0x2::tx_context::sender(arg5),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CollectionUpdated>(v0);
    }

    public entry fun update_max_supply(arg0: &mut Collection, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(arg1 >= arg0.current_supply, 16);
        arg0.max_supply = arg1;
        let v0 = MaxSupplyUpdated{
            collection_id  : 0x2::object::uid_to_inner(&arg0.id),
            old_max_supply : arg0.max_supply,
            new_max_supply : arg1,
            updated_by     : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MaxSupplyUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

