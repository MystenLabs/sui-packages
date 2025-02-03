module 0xaf7a312f6c3119d361732ae7a154f799841289c46623839c94c9987de1053558::vault {
    struct Vault<phantom T0, phantom T1, phantom T2, T3: store> has store, key {
        id: 0x2::object::UID,
        config: 0xaf7a312f6c3119d361732ae7a154f799841289c46623839c94c9987de1053558::config::Config<T0, T1, T2>,
        protocol_config: T3,
        extra_info: 0x2::bag::Bag,
    }

    public(friend) fun new<T0, T1, T2, T3: store>(arg0: 0xaf7a312f6c3119d361732ae7a154f799841289c46623839c94c9987de1053558::config::Config<T0, T1, T2>, arg1: T3, arg2: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2, T3> {
        Vault<T0, T1, T2, T3>{
            id              : 0x2::object::new(arg2),
            config          : arg0,
            protocol_config : arg1,
            extra_info      : 0x2::bag::new(arg2),
        }
    }

    public(friend) fun config<T0, T1, T2, T3: store>(arg0: &Vault<T0, T1, T2, T3>) : &0xaf7a312f6c3119d361732ae7a154f799841289c46623839c94c9987de1053558::config::Config<T0, T1, T2> {
        &arg0.config
    }

    public(friend) fun config_mut<T0, T1, T2, T3: store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut 0xaf7a312f6c3119d361732ae7a154f799841289c46623839c94c9987de1053558::config::Config<T0, T1, T2> {
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

