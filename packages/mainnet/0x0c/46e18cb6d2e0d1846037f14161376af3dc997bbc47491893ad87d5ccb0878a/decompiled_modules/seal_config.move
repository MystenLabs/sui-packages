module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::seal_config {
    struct SealConfig has key {
        id: 0x2::object::UID,
        key_server_id: 0x2::object::ID,
        aggregator_url: 0x1::option::Option<0x1::string::String>,
        weight: u8,
    }

    struct SealConfigID has copy, drop, store {
        config_id: 0x2::object::ID,
    }

    public fun id(arg0: &SealConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x1::string::String>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : SealConfigID {
        let v0 = SealConfig{
            id             : 0x2::object::new(arg3),
            key_server_id  : arg0,
            aggregator_url : arg1,
            weight         : arg2,
        };
        0x2::transfer::freeze_object<SealConfig>(v0);
        new_config_id(&v0)
    }

    public fun aggregator_url(arg0: &SealConfig) : &0x1::option::Option<0x1::string::String> {
        &arg0.aggregator_url
    }

    public fun key_server_id(arg0: &SealConfig) : 0x2::object::ID {
        arg0.key_server_id
    }

    public fun new_config_id(arg0: &SealConfig) : SealConfigID {
        SealConfigID{config_id: 0x2::object::id<SealConfig>(arg0)}
    }

    public fun to_inner(arg0: &SealConfigID) : 0x2::object::ID {
        arg0.config_id
    }

    public fun weight(arg0: &SealConfig) : u8 {
        arg0.weight
    }

    // decompiled from Move bytecode v7
}

