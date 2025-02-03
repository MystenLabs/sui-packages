module 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault {
    struct Vault<phantom T0, phantom T1, phantom T2, T3: store> has store, key {
        id: 0x2::object::UID,
        config: 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::Config<T0, T1, T2>,
        protocol_config: T3,
        extra_info: 0x2::bag::Bag,
    }

    public(friend) fun new<T0, T1, T2, T3: store>(arg0: 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::Config<T0, T1, T2>, arg1: T3, arg2: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2, T3> {
        Vault<T0, T1, T2, T3>{
            id              : 0x2::object::new(arg2),
            config          : arg0,
            protocol_config : arg1,
            extra_info      : 0x2::bag::new(arg2),
        }
    }

    public(friend) fun config<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : &0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::Config<T0, T1, T2> {
        &arg0.config
    }

    public(friend) fun config_mut<T0, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::Config<T0, T1, T2> {
        &mut arg0.config
    }

    public(friend) fun protocol_config<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : &T3 {
        &arg0.protocol_config
    }

    public(friend) fun protocol_config_mut<T0, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut T3 {
        &mut arg0.protocol_config
    }

    // decompiled from Move bytecode v6
}

