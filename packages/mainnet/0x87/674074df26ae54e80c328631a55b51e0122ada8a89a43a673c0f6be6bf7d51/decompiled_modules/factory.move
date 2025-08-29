module 0x87674074df26ae54e80c328631a55b51e0122ada8a89a43a673c0f6be6bf7d51::factory {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeStore has store, key {
        id: 0x2::object::UID,
        fee: u64,
        admin_cap_id: 0x2::object::ID,
    }

    struct FeeUpdatedEvent has copy, drop, store {
        old_fee: u64,
        new_fee: u64,
    }

    struct TokenCreationEvent has copy, drop, store {
        creator: address,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        initial_supply: u64,
        metadata_uri: vector<u8>,
        description: vector<u8>,
        network: vector<u8>,
    }

    public entry fun create_token(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &FeeStore, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1.fee, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xcaf14df9da34a51e9370b877d44ad6e31f14c0596990cbe85ce579546930f2d4);
        let v0 = TokenCreationEvent{
            creator        : 0x2::tx_context::sender(arg9),
            name           : arg2,
            symbol         : arg3,
            decimals       : arg4,
            initial_supply : arg5,
            metadata_uri   : arg6,
            description    : arg7,
            network        : arg8,
        };
        0x2::event::emit<TokenCreationEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = FeeStore{
            id           : 0x2::object::new(arg0),
            fee          : 1000000000,
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FeeStore>(v1);
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut FeeStore, arg2: u64) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 0);
        arg1.fee = arg2;
        let v0 = FeeUpdatedEvent{
            old_fee : arg1.fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

