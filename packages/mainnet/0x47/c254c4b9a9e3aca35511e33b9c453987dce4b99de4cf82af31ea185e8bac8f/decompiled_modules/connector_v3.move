module 0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3 {
    struct ConnectorV3<phantom T0> has store, key {
        id: 0x2::object::UID,
        temp_id: u64,
        supply: 0x2::balance::Balance<T0>,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        telegram: 0x1::string::String,
        creator: address,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, arg3, arg2, arg4, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(arg5))), arg9);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v3 = ConnectorV3<T0>{
            id           : 0x2::object::new(arg9),
            temp_id      : arg1,
            supply       : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut v2, 1000000000000000, arg9)),
            twitter      : arg6,
            website      : arg7,
            telegram     : arg8,
            creator      : 0x2::tx_context::sender(arg9),
            treasury_cap : v2,
        };
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::events::emit_connector_create_v3<T0>(get_id<T0>(&v3));
        0x2::transfer::public_transfer<ConnectorV3<T0>>(v3, @0x395235790b1966583d36455dc973fdff0e10198720aedc6e2475bf3e27fbdb35);
    }

    public fun deconstruct<T0>(arg0: ConnectorV3<T0>) : (0x2::object::UID, 0x2::balance::Balance<T0>, 0x1::string::String, 0x1::string::String, 0x1::string::String, address, 0x2::coin::TreasuryCap<T0>) {
        let ConnectorV3 {
            id           : v0,
            temp_id      : _,
            supply       : v2,
            twitter      : v3,
            website      : v4,
            telegram     : v5,
            creator      : v6,
            treasury_cap : v7,
        } = arg0;
        (v0, v2, v3, v4, v5, v6, v7)
    }

    public fun get_creator<T0>(arg0: &ConnectorV3<T0>) : address {
        arg0.creator
    }

    public fun get_id<T0>(arg0: &ConnectorV3<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_temp_id<T0>(arg0: &ConnectorV3<T0>) : u64 {
        arg0.temp_id
    }

    // decompiled from Move bytecode v6
}

