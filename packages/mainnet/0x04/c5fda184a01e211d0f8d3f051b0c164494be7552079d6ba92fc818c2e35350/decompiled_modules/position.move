module 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::position {
    struct JewelTurbosPosition has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        share: u128,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : JewelTurbosPosition {
        JewelTurbosPosition{
            id          : 0x2::object::new(arg2),
            farm_id     : arg0,
            share       : arg1,
            name        : 0x1::string::utf8(b"Jewel Turbos Farm Position"),
            description : 0x1::string::utf8(b"Jewel Turbos Farm Position"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/25179.png"),
        }
    }

    public(friend) fun decrease_share(arg0: &mut JewelTurbosPosition, arg1: u128) {
        arg0.share = arg0.share - arg1;
    }

    public(friend) fun destroy(arg0: JewelTurbosPosition) {
        let JewelTurbosPosition {
            id          : v0,
            farm_id     : _,
            share       : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_position_info(arg0: &JewelTurbosPosition) : (0x2::object::ID, u128) {
        (arg0.farm_id, arg0.share)
    }

    public(friend) fun increase_share(arg0: &mut JewelTurbosPosition, arg1: u128) {
        arg0.share = arg0.share + arg1;
    }

    public(friend) fun transfer_position_and_coins<T0, T1>(arg0: JewelTurbosPosition, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: address) {
        0x2::transfer::public_transfer<JewelTurbosPosition>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

