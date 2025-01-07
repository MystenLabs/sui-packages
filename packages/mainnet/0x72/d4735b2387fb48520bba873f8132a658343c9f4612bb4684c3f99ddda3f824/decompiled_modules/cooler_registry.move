module 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::cooler_registry {
    struct CoolerRegistry has key {
        id: 0x2::object::UID,
        fee: u64,
        name_to_id: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        treasury: address,
    }

    struct CoolerRegistryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_fee(arg0: &CoolerRegistry) : u64 {
        arg0.fee
    }

    public fun get_water_cooler(arg0: &CoolerRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.name_to_id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoolerRegistryOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CoolerRegistryOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CoolerRegistry{
            id         : 0x2::object::new(arg0),
            fee        : 100000000,
            name_to_id : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            treasury   : @0xfb9d4d41b2214a5f370e5f899359040b0b2afe534e9e8eed35c9e0d1fecd45e1,
        };
        0x2::transfer::share_object<CoolerRegistry>(v1);
    }

    public entry fun register_water_cooler(arg0: &mut CoolerRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::water_cooler::WaterCooler, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee, 0);
        assert!(0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::water_cooler::owner(arg2) == 0x2::tx_context::sender(arg4), 1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.name_to_id, arg3), 2);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.name_to_id, arg3, 0x2::object::id<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::water_cooler::WaterCooler>(arg2));
        send_fees(arg0, arg1);
    }

    public(friend) fun send_fees(arg0: &CoolerRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public entry fun update_fee(arg0: &CoolerRegistryOwnerCap, arg1: &mut CoolerRegistry, arg2: u64) {
        arg1.fee = arg2;
    }

    // decompiled from Move bytecode v6
}

