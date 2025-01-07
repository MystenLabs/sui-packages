module 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::launchpad {
    struct CreateCollectionData has drop {
        id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
        autoreserve_interval: u64,
        royalty_numerator: u16,
        min_amount: u64,
        account_address: vector<u8>,
    }

    struct CreateMintTokenOrderData has drop {
        store: vector<u8>,
        clock: vector<u8>,
        expire_time_in_seconds: u64,
        token_type: u64,
        id: 0x1::string::String,
        collection_id: 0x1::string::String,
        stage_id: 0x1::string::String,
        stage_max_supply: u64,
        price: u64,
        fee: u64,
        allow_update: bool,
        account_address: vector<u8>,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        collection_id: 0x1::string::String,
        name: 0x1::string::String,
        creator: address,
        address: address,
        autoreserve_interval: u64,
        max_supply: u64,
        minted: u64,
        autoreserve_minted: u64,
    }

    struct Stage has store, key {
        id: 0x2::object::UID,
        stage_id: 0x1::string::String,
        collection_id: 0x1::string::String,
        max_supply: u64,
        minted: u64,
    }

    struct MintTokenOrder has copy, drop, store {
        index: u64,
        id: 0x1::string::String,
        creator: address,
        collection_id: 0x1::string::String,
        stage_id: 0x1::string::String,
        token_type: u64,
        price: u64,
        fee: u64,
        minted_token: 0x1::option::Option<vector<u8>>,
        reserve_token_for_collection_creator: bool,
        reserved_token_for_collection_creator: 0x1::option::Option<vector<u8>>,
        allow_update: bool,
    }

    struct CreateCollectionEvent has copy, drop {
        id: 0x1::string::String,
        creator: address,
        address: address,
        name: 0x1::string::String,
        nft_cap_id: address,
        display_id: address,
    }

    struct CreateStageEvent has copy, drop {
        id: 0x1::string::String,
        collection_id: 0x1::string::String,
    }

    struct CreateMintTokenOrderEvent has copy, drop {
        index: u64,
        id: 0x1::string::String,
        creator: address,
        collection_id: 0x1::string::String,
        token_type: u64,
        reserve_token_for_collection_creator: bool,
    }

    struct MintTokenEvent has copy, drop {
        order_index: u64,
        order_id: 0x1::string::String,
        stage_id: 0x1::string::String,
        collection_id: 0x1::string::String,
        creator: address,
        address: address,
        autoreserved_address: address,
        name: 0x1::string::String,
    }

    struct LaunchpadStore has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    public entry fun admin_create_collection<T0: drop + store>(arg0: &mut LaunchpadStore, arg1: &0x2::package::Publisher, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u16, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == @0x862cbc9f1a76b0df55b4dcb4fbc170fc91ecdddaa0072941d4db6be1a2e5e5a9, 1);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = CreateCollectionData{
            id                   : arg3,
            name                 : arg4,
            description          : arg5,
            image_url            : arg6,
            max_supply           : arg7,
            autoreserve_interval : arg8,
            royalty_numerator    : arg9,
            min_amount           : arg10,
            account_address      : 0x1::bcs::to_bytes<address>(&v0),
        };
        create_collection_internal<T0>(arg0, arg1, arg2, &v1, arg11);
    }

    public entry fun admin_initialize(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        require_admin_rights(arg1);
        let v0 = LaunchpadStore{
            id         : 0x2::object::new(arg1),
            public_key : arg0,
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            version    : 1,
        };
        0x2::transfer::share_object<LaunchpadStore>(v0);
    }

    public entry fun admin_mint_token_into_kiosk<T0: drop + store>(arg0: &0x2::transfer_policy::TransferPolicy<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>, arg1: &mut LaunchpadStore, arg2: &mut 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::NftCap<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        require_admin_rights(arg11);
        let v0 = get_collection(arg1, arg3).creator;
        mint_token_internal_into_kiosk<T0>(arg1, arg0, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun admin_set_public_Key(arg0: &mut LaunchpadStore, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        require_admin_rights(arg2);
        arg0.public_key = arg1;
    }

    fun create_collection_internal<T0: drop + store>(arg0: &mut LaunchpadStore, arg1: &0x2::package::Publisher, arg2: address, arg3: &CreateCollectionData, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, get_dynamic_field_key(b"Collection", arg3.id)), 3);
        let (v0, v1, v2, v3) = 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::register_nft_type<T0>(arg1, arg3.max_supply, arg3.royalty_numerator, arg3.min_amount, arg4);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = Collection{
            id                   : 0x2::object::new(arg4),
            collection_id        : arg3.id,
            name                 : arg3.name,
            creator              : arg2,
            address              : 0x2::object::id_address<0x2::transfer_policy::TransferPolicy<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>>(&v4),
            autoreserve_interval : arg3.autoreserve_interval,
            max_supply           : arg3.max_supply,
            minted               : 0,
            autoreserve_minted   : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg3.id), v7);
        let v8 = CreateCollectionEvent{
            id         : arg3.id,
            creator    : arg2,
            address    : 0x2::object::id_address<Collection>(&v7),
            name       : arg3.name,
            nft_cap_id : 0x2::object::id_address<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::NftCap<T0>>(&v6),
            display_id : 0x2::object::id_address<0x2::display::Display<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>>(&v5),
        };
        0x2::event::emit<CreateCollectionEvent>(v8);
        0x2::transfer::public_transfer<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::NftCap<T0>>(v6, @0x862cbc9f1a76b0df55b4dcb4fbc170fc91ecdddaa0072941d4db6be1a2e5e5a9);
        0x2::transfer::public_transfer<0x2::display::Display<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>>(v5, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>>(v3, arg2);
    }

    public entry fun create_mint_token_order(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut LaunchpadStore, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = CreateMintTokenOrderData{
            store                  : 0x1::vector::empty<u8>(),
            clock                  : 0x1::vector::empty<u8>(),
            expire_time_in_seconds : arg3,
            token_type             : arg4,
            id                     : arg5,
            collection_id          : arg6,
            stage_id               : arg7,
            stage_max_supply       : arg8,
            price                  : arg9,
            fee                    : arg10,
            allow_update           : arg11,
            account_address        : 0x1::bcs::to_bytes<address>(&v0),
        };
        0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::signature::verify_signature<CreateMintTokenOrderData>(&v1, arg12, arg1.public_key);
        create_mint_token_order_internal(arg1, arg2, arg0, &v1, arg13);
    }

    fun create_mint_token_order_internal(arg0: &mut LaunchpadStore, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &CreateMintTokenOrderData, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg3.expire_time_in_seconds * 1000, 2);
        require_collection_exists(arg0, arg3.collection_id);
        create_stage_for_mint_token_order_if_need(arg0, arg3, arg4);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&get_stage(arg0, arg3.collection_id, arg3.stage_id).id, get_dynamic_field_key(b"MintTokenOrder", arg3.id)), 5);
        require_collection_max_supply_not_reached(arg0, arg3.collection_id);
        require_stage_max_supply_not_reached(arg0, arg3.collection_id, arg3.stage_id);
        let v0 = false;
        increment_collection_minted(arg0, arg3.collection_id);
        increment_stage_minted(arg0, arg3.collection_id, arg3.stage_id);
        let v1 = get_collection(arg0, arg3.collection_id);
        let v2 = v1.minted + v1.autoreserve_minted - 1;
        if (v1.autoreserve_interval > 0) {
            if (v1.minted % v1.autoreserve_interval == 0 && is_collection_max_supply_not_reached(arg0, arg3.collection_id) && is_stage_max_supply_not_reached(arg0, arg3.collection_id, arg3.stage_id)) {
                increment_collection_autoreserve_minted(arg0, arg3.collection_id);
                increment_stage_minted(arg0, arg3.collection_id, arg3.stage_id);
                v0 = true;
            };
        };
        let v3 = MintTokenOrder{
            index                                 : v2,
            id                                    : arg3.id,
            creator                               : 0x2::tx_context::sender(arg4),
            collection_id                         : arg3.collection_id,
            stage_id                              : arg3.stage_id,
            token_type                            : arg3.token_type,
            price                                 : arg3.price,
            fee                                   : arg3.fee,
            minted_token                          : 0x1::option::none<vector<u8>>(),
            reserve_token_for_collection_creator  : v0,
            reserved_token_for_collection_creator : 0x1::option::none<vector<u8>>(),
            allow_update                          : arg3.allow_update,
        };
        if (v3.fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v3.fee, arg4), @0x862cbc9f1a76b0df55b4dcb4fbc170fc91ecdddaa0072941d4db6be1a2e5e5a9);
        };
        if (v3.price > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v3.price, arg4), get_collection(arg0, arg3.collection_id).creator);
        };
        0x2::dynamic_field::add<0x1::string::String, MintTokenOrder>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Stage>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg3.collection_id)).id, get_dynamic_field_key(b"Stage", arg3.stage_id)).id, get_dynamic_field_key(b"MintTokenOrder", v3.id), v3);
        let v4 = CreateMintTokenOrderEvent{
            index                                : v2,
            id                                   : v3.id,
            creator                              : v3.creator,
            collection_id                        : v3.collection_id,
            token_type                           : v3.token_type,
            reserve_token_for_collection_creator : v3.reserve_token_for_collection_creator,
        };
        0x2::event::emit<CreateMintTokenOrderEvent>(v4);
    }

    fun create_stage_for_mint_token_order_if_need(arg0: &mut LaunchpadStore, arg1: &CreateMintTokenOrderData, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&get_collection(arg0, arg1.collection_id).id, get_dynamic_field_key(b"Stage", arg1.stage_id))) {
            create_stage_internal(arg0, arg1.stage_id, arg1.collection_id, arg1.stage_max_supply, arg2);
        };
    }

    fun create_stage_internal(arg0: &mut LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg2));
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&v0.id, get_dynamic_field_key(b"Stage", arg1)), 4);
        let v1 = Stage{
            id            : 0x2::object::new(arg4),
            stage_id      : arg1,
            collection_id : arg2,
            max_supply    : arg3,
            minted        : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, Stage>(&mut v0.id, get_dynamic_field_key(b"Stage", arg1), v1);
        let v2 = CreateStageEvent{
            id            : arg1,
            collection_id : arg2,
        };
        0x2::event::emit<CreateStageEvent>(v2);
    }

    fun get_collection(arg0: &LaunchpadStore, arg1: 0x1::string::String) : &Collection {
        require_collection_exists(arg0, arg1);
        0x2::dynamic_object_field::borrow<0x1::string::String, Collection>(&arg0.id, get_dynamic_field_key(b"Collection", arg1))
    }

    fun get_dynamic_field_key(arg0: vector<u8>, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"::");
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(&arg1));
        0x1::string::utf8(v0)
    }

    fun get_stage(arg0: &LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String) : &Stage {
        require_stage_exists(arg0, arg1, arg2);
        0x2::dynamic_object_field::borrow<0x1::string::String, Stage>(&get_collection(arg0, arg1).id, get_dynamic_field_key(b"Stage", arg2))
    }

    fun increment_collection_autoreserve_minted(arg0: &mut LaunchpadStore, arg1: 0x1::string::String) {
        require_collection_exists(arg0, arg1);
        require_collection_max_supply_not_reached(arg0, arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg1));
        v0.autoreserve_minted = v0.autoreserve_minted + 1;
    }

    fun increment_collection_minted(arg0: &mut LaunchpadStore, arg1: 0x1::string::String) {
        require_collection_exists(arg0, arg1);
        require_collection_max_supply_not_reached(arg0, arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg1));
        v0.minted = v0.minted + 1;
    }

    fun increment_stage_minted(arg0: &mut LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        require_stage_exists(arg0, arg1, arg2);
        require_stage_max_supply_not_reached(arg0, arg1, arg2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Stage>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg1)).id, get_dynamic_field_key(b"Stage", arg2));
        v0.minted = v0.minted + 1;
    }

    fun is_collection_max_supply_not_reached(arg0: &LaunchpadStore, arg1: 0x1::string::String) : bool {
        let v0 = get_collection(arg0, arg1);
        v0.max_supply == 0 || v0.minted + v0.autoreserve_minted < v0.max_supply
    }

    fun is_stage_max_supply_not_reached(arg0: &LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        let v0 = get_stage(arg0, arg1, arg2);
        v0.max_supply == 0 || v0.minted < v0.max_supply
    }

    fun mint_one_token_into_kiosk<T0: drop + store>(arg0: &mut 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::NftCap<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::mint_into_kiosk<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<T0>(), 0x1::option::some<address>(arg2), 0x1::vector::empty<vector<u8>>(), arg8, arg9);
        0x2::object::id_to_address(&v0)
    }

    fun mint_token_internal_into_kiosk<T0: drop + store>(arg0: &mut LaunchpadStore, arg1: &0x2::transfer_policy::TransferPolicy<0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::Nft<T0>>, arg2: &mut 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::tradeport::NftCap<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x0;
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, MintTokenOrder>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Stage>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Collection>(&mut arg0.id, get_dynamic_field_key(b"Collection", arg3)).id, get_dynamic_field_key(b"Stage", arg4)).id, get_dynamic_field_key(b"MintTokenOrder", arg5));
        assert!(0x1::option::is_none<vector<u8>>(&v1.minted_token), 10);
        let v2 = mint_one_token_into_kiosk<T0>(arg2, arg1, v1.creator, arg7, arg8, arg9, arg10, arg11, v1.price, arg12);
        v1.minted_token = 0x1::option::some<vector<u8>>(0x1::bcs::to_bytes<address>(&v2));
        if (v1.reserve_token_for_collection_creator) {
            v0 = mint_one_token_into_kiosk<T0>(arg2, arg1, arg6, arg7, arg8, arg9, arg10, arg11, 0, arg12);
            v1.reserved_token_for_collection_creator = 0x1::option::some<vector<u8>>(0x1::bcs::to_bytes<address>(&v0));
        };
        let v3 = MintTokenEvent{
            order_index          : v1.index,
            order_id             : v1.id,
            stage_id             : v1.stage_id,
            collection_id        : v1.collection_id,
            creator              : v1.creator,
            address              : v2,
            autoreserved_address : v0,
            name                 : arg7,
        };
        0x2::event::emit<MintTokenEvent>(v3);
    }

    fun require_admin_rights(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x862cbc9f1a76b0df55b4dcb4fbc170fc91ecdddaa0072941d4db6be1a2e5e5a9, 1);
    }

    fun require_collection_exists(arg0: &LaunchpadStore, arg1: 0x1::string::String) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, get_dynamic_field_key(b"Collection", arg1)), 6);
    }

    fun require_collection_max_supply_not_reached(arg0: &LaunchpadStore, arg1: 0x1::string::String) {
        assert!(is_collection_max_supply_not_reached(arg0, arg1), 9);
    }

    fun require_stage_exists(arg0: &LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&get_collection(arg0, arg1).id, get_dynamic_field_key(b"Stage", arg2)), 7);
    }

    fun require_stage_max_supply_not_reached(arg0: &LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(is_stage_max_supply_not_reached(arg0, arg1, arg2), 8);
    }

    // decompiled from Move bytecode v6
}

