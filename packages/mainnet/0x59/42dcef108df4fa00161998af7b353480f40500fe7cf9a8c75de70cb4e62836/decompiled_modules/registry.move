module 0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::registry {
    struct Registry has store, key {
        id: 0x2::object::UID,
        version: 0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::version::Version,
        table: 0x2::bag::Bag,
    }

    struct Entry<T0: store> has copy, store {
        admin_cap_id: 0x2::object::ID,
        liquid_staking_info_id: 0x2::object::ID,
        extra_info: T0,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id      : 0x2::object::new(arg0),
            version : 0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::version::new(1),
            table   : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun add_to_registry<T0, T1: store>(arg0: &mut Registry, arg1: &0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::liquid_staking::AdminCap<T0>, arg2: &0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::liquid_staking::LiquidStakingInfo<T0>, arg3: T1) {
        0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = Entry<T1>{
            admin_cap_id           : 0x2::object::id<0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::liquid_staking::AdminCap<T0>>(arg1),
            liquid_staking_info_id : 0x2::object::id<0x5942dcef108df4fa00161998af7b353480f40500fe7cf9a8c75de70cb4e62836::liquid_staking::LiquidStakingInfo<T0>>(arg2),
            extra_info             : arg3,
        };
        0x2::bag::add<0x1::type_name::TypeName, Entry<T1>>(&mut arg0.table, 0x1::type_name::get<T0>(), v0);
    }

    public fun admin_cap_id<T0: store>(arg0: &Entry<T0>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun extra_info<T0: store>(arg0: &Entry<T0>) : &T0 {
        &arg0.extra_info
    }

    public(friend) fun get_entry<T0, T1: store>(arg0: &Registry) : &Entry<T1> {
        0x2::bag::borrow<0x1::type_name::TypeName, Entry<T1>>(&arg0.table, 0x1::type_name::get<T0>())
    }

    public fun liquid_staking_info_id<T0: store>(arg0: &Entry<T0>) : 0x2::object::ID {
        arg0.liquid_staking_info_id
    }

    // decompiled from Move bytecode v6
}

