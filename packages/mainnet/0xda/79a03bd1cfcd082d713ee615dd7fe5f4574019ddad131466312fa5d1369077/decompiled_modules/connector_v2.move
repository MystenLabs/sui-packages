module 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2 {
    struct ConnectorV2<phantom T0> has store, key {
        id: 0x2::object::UID,
        temp_id: u64,
        supply: 0x2::balance::Balance<T0>,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        telegram: 0x1::string::String,
        creator: address,
    }

    public(friend) fun deconstruct<T0>(arg0: ConnectorV2<T0>) : (0x2::object::UID, 0x2::balance::Balance<T0>, 0x1::string::String, 0x1::string::String, 0x1::string::String, address) {
        let ConnectorV2 {
            id       : v0,
            temp_id  : _,
            supply   : v2,
            twitter  : v3,
            website  : v4,
            telegram : v5,
            creator  : v6,
        } = arg0;
        (v0, v2, v3, v4, v5, v6)
    }

    public fun get_creator<T0>(arg0: &ConnectorV2<T0>) : address {
        arg0.creator
    }

    public fun get_id<T0>(arg0: &ConnectorV2<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_temp_id<T0>(arg0: &ConnectorV2<T0>) : u64 {
        arg0.temp_id
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    // decompiled from Move bytecode v6
}

