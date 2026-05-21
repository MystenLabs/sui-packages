module 0x1eb66a5998f63365af581f3fd13de8c1f780a592a30b2c485f23f08fa0ed2b8a::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        owner: address,
        launches: u64,
    }

    struct LaunchEvent has copy, drop {
        creator: address,
        package_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        initial_supply: u64,
        revoked_on_launch: bool,
        launch_no: u64,
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            launches : 0,
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public fun launches(arg0: &Factory) : u64 {
        arg0.launches
    }

    public fun owner(arg0: &Factory) : address {
        arg0.owner
    }

    public entry fun record_launch(arg0: &mut Factory, arg1: &0x2::package::UpgradeCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        arg0.launches = arg0.launches + 1;
        let v0 = LaunchEvent{
            creator           : 0x2::tx_context::sender(arg7),
            package_id        : 0x2::package::upgrade_package(arg1),
            name              : arg2,
            symbol            : arg3,
            decimals          : arg4,
            initial_supply    : arg5,
            revoked_on_launch : arg6,
            launch_no         : arg0.launches,
        };
        0x2::event::emit<LaunchEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

