module 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::cooler_factory {
    struct CoolerFactory has key {
        id: 0x2::object::UID,
        fee: u64,
        treasury: address,
        cooler_list: vector<0x2::object::ID>,
    }

    struct FactoryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun buy_water_cooler(arg0: &mut CoolerFactory, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee, 0);
        let (v0, v1) = 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::orchestrator::create_mint_distributer(arg8);
        let v2 = v1;
        let v3 = v0;
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::transfer_setting(v3, arg8);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::transfer_warehouse(v2, arg8);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.cooler_list, 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::create_water_cooler(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(&v3), 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(&v2), arg8));
        send_fees(arg0, arg1);
    }

    public fun get_fee(arg0: &CoolerFactory) : u64 {
        arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FactoryOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CoolerFactory{
            id          : 0x2::object::new(arg0),
            fee         : 0,
            treasury    : @0xfb9d4d41b2214a5f370e5f899359040b0b2afe534e9e8eed35c9e0d1fecd45e1,
            cooler_list : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<CoolerFactory>(v1);
    }

    public(friend) fun send_fees(arg0: &CoolerFactory, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public entry fun update_fee(arg0: &FactoryOwnerCap, arg1: &mut CoolerFactory, arg2: u64) {
        arg1.fee = arg2;
    }

    // decompiled from Move bytecode v6
}

