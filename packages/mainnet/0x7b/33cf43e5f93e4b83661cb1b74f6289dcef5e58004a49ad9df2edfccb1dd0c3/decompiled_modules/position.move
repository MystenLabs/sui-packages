module 0x7b33cf43e5f93e4b83661cb1b74f6289dcef5e58004a49ad9df2edfccb1dd0c3::position {
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
        assert!(arg0.share == 0, 201);
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

    public fun get_info(arg0: &JewelTurbosPosition) : (0x2::object::ID, u128) {
        (arg0.farm_id, arg0.share)
    }

    public(friend) fun increase_share(arg0: &mut JewelTurbosPosition, arg1: u128) {
        arg0.share = arg0.share + arg1;
    }

    public(friend) fun merge(arg0: &mut JewelTurbosPosition, arg1: JewelTurbosPosition) {
        arg0.share = arg0.share + arg1.share;
        let JewelTurbosPosition {
            id          : v0,
            farm_id     : _,
            share       : _,
            name        : _,
            description : _,
            url         : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

