module 0x84fc3aa28b8b39cfa27af042346c87f2f5799bcc8e1e86e881a139af591755f1::launchpad {
    struct MintTokenOrder has copy, drop, store {
        expire_time_in_seconds: u64,
        order_id: 0x1::string::String,
        collection_id: 0x1::string::String,
        price: u64,
        fee: u64,
        token_type: u64,
        stage_id: 0x1::option::Option<0x1::string::String>,
        minted_token: 0x1::option::Option<vector<u8>>,
        account_address: vector<u8>,
        reserve_token_for_collection_creator: bool,
        reserved_token_for_collection_creator: 0x1::option::Option<vector<u8>>,
    }

    struct CollectionData has copy, drop, store {
        id: 0x1::string::String,
        name: 0x1::string::String,
        creator: address,
        address: address,
    }

    struct Stage has copy, drop, store {
        supply: u64,
        autoreserve_interval: 0x1::option::Option<u64>,
        counter: u64,
        autoreserve_counter: u64,
        collection_address: address,
    }

    struct CreateMintTokenOrderEvent has copy, drop, store {
        creator: address,
        id: 0x1::string::String,
        collection_id: 0x1::string::String,
        token_type: u64,
        reserve_token_for_collection_creator: bool,
    }

    struct CreateStageEvent has copy, drop, store {
        collection_address: address,
        collection_id: 0x1::string::String,
        id: 0x1::string::String,
    }

    struct MintTokenEvent has copy, drop, store {
        creator: address,
        id: 0x1::string::String,
        collection_id: 0x1::string::String,
        address: address,
        autoreserved_address: address,
        name: 0x1::string::String,
    }

    struct LaunchpadStore has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        version: u64,
    }

    public fun admin_add_existing_collection(arg0: &mut LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == @0x8429a7841f924e1e030191bfd69f22112934e7d2c7694bc07586f94acec60a02, 1);
        let v0 = CollectionData{
            id      : arg1,
            name    : arg2,
            creator : arg3,
            address : arg4,
        };
        0x2::dynamic_field::add<vector<u8>, CollectionData>(&mut arg0.id, get_key(b"collection", arg1), v0);
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            let v1 = 4294967295;
            create_collection_stage(arg0, arg1, arg4, *0x1::option::borrow<0x1::string::String>(&arg5), *0x1::option::borrow_with_default<u64>(&arg6, &v1), arg7, arg8);
        };
    }

    public entry fun admin_add_existing_collection_with_stage(arg0: &mut LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        admin_add_existing_collection(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x1::string::String>(arg5), 0x1::option::some<u64>(arg6), 0x1::option::some<u64>(arg7), arg8);
    }

    fun create_collection_stage(arg0: &mut LaunchpadStore, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Stage{
            supply               : arg4,
            autoreserve_interval : arg5,
            counter              : 0,
            autoreserve_counter  : 0,
            collection_address   : arg2,
        };
        0x2::dynamic_field::add<vector<u8>, Stage>(&mut arg0.id, get_key(b"stage", arg3), v0);
        let v1 = CreateStageEvent{
            collection_address : arg2,
            collection_id      : arg1,
            id                 : arg3,
        };
        0x2::event::emit<CreateStageEvent>(v1);
    }

    public entry fun create_mint_stage_token_order(arg0: &0x2::clock::Clock, arg1: &mut LaunchpadStore, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 * 1000 > 0x2::clock::timestamp_ms(arg0), 3);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = MintTokenOrder{
            expire_time_in_seconds                : arg5,
            order_id                              : arg4,
            collection_id                         : arg6,
            price                                 : arg7,
            fee                                   : arg8,
            token_type                            : 0,
            stage_id                              : 0x1::option::some<0x1::string::String>(arg3),
            minted_token                          : 0x1::option::none<vector<u8>>(),
            account_address                       : 0x1::bcs::to_bytes<address>(&v0),
            reserve_token_for_collection_creator  : false,
            reserved_token_for_collection_creator : 0x1::option::none<vector<u8>>(),
        };
        0x84fc3aa28b8b39cfa27af042346c87f2f5799bcc8e1e86e881a139af591755f1::signature::verify_signature<MintTokenOrder>(&v1, arg9, arg1.public_key);
        let v2 = get_key(b"collection", v1.collection_id);
        let v3 = get_key(b"token_orders", v1.order_id);
        let v4 = get_key(b"stage", arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v2), 4);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v3), 5);
        assert!(0x2::dynamic_field::borrow<vector<u8>, Stage>(&arg1.id, v4).collection_address == 0x2::dynamic_field::borrow<vector<u8>, CollectionData>(&arg1.id, v2).address, 2);
        let v5 = 0x2::dynamic_field::borrow_mut<vector<u8>, Stage>(&mut arg1.id, v4);
        decrement_supply_for_stage(v5);
        v1.reserve_token_for_collection_creator = increment_counter_for_stage(v5);
        0x2::dynamic_field::add<vector<u8>, MintTokenOrder>(&mut arg1.id, v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg7 + arg8, arg10), @0x8429a7841f924e1e030191bfd69f22112934e7d2c7694bc07586f94acec60a02);
        let v6 = CreateMintTokenOrderEvent{
            creator                              : 0x2::tx_context::sender(arg10),
            id                                   : v1.order_id,
            collection_id                        : v1.collection_id,
            token_type                           : v1.token_type,
            reserve_token_for_collection_creator : v1.reserve_token_for_collection_creator,
        };
        0x2::event::emit<CreateMintTokenOrderEvent>(v6);
    }

    fun decrement_supply_for_stage(arg0: &mut Stage) {
        assert!(arg0.supply > 0, 6);
        arg0.supply = arg0.supply - 1;
    }

    fun get_key(arg0: vector<u8>, arg1: 0x1::string::String) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"::");
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(&arg1));
        v0
    }

    fun increment_counter_for_stage(arg0: &mut Stage) : bool {
        arg0.counter = arg0.counter + 1;
        if (0x1::option::is_some<u64>(&arg0.autoreserve_interval) && arg0.supply > 0) {
            let v0 = *0x1::option::borrow<u64>(&arg0.autoreserve_interval);
            if (v0 > 0 && (arg0.counter + 1) % v0 == 0) {
                arg0.counter = arg0.counter + 1;
                arg0.supply = arg0.supply - 1;
                arg0.autoreserve_counter = arg0.autoreserve_counter + 1;
                return true
            };
        };
        false
    }

    public entry fun initialize(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x8429a7841f924e1e030191bfd69f22112934e7d2c7694bc07586f94acec60a02, 1);
        let v0 = LaunchpadStore{
            id         : 0x2::object::new(arg1),
            public_key : arg0,
            version    : 1,
        };
        0x2::transfer::share_object<LaunchpadStore>(v0);
    }

    public entry fun mint_token(arg0: &mut LaunchpadStore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = MintTokenEvent{
            creator              : 0x2::tx_context::sender(arg6),
            id                   : arg1,
            collection_id        : arg5,
            address              : @0xc0ffee,
            autoreserved_address : @0x0,
            name                 : arg2,
        };
        0x2::event::emit<MintTokenEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

