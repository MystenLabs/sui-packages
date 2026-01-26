module 0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        paused: bool,
        wl_only: bool,
        whitelists: vector<address>,
        oraclers: vector<address>,
    }

    public fun add_oracler(arg0: &mut Config, arg1: &0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::admin::AdminCap, arg2: address) {
        if (!0x1::vector::contains<address>(&arg0.oraclers, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.oraclers, arg2);
        };
    }

    public fun add_whitelist(arg0: &mut Config, arg1: &0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::admin::AdminCap, arg2: address) {
        if (!is_whitelisted(arg0, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelists, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id         : 0x2::object::new(arg0),
            paused     : false,
            wl_only    : false,
            whitelists : 0x1::vector::empty<address>(),
            oraclers   : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    public(friend) fun is_oracler(arg0: &Config, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.oraclers, &arg1)
    }

    public(friend) fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public(friend) fun is_whitelisted(arg0: &Config, arg1: address) : bool {
        !arg0.wl_only || 0x1::vector::contains<address>(&arg0.whitelists, &arg1)
    }

    public fun remove_oracler(arg0: &mut Config, arg1: &0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::admin::AdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.oraclers, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.oraclers, v1);
        };
    }

    public fun remove_whitelist(arg0: &mut Config, arg1: &0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::admin::AdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelists, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.whitelists, v1);
        };
    }

    public fun set_paused(arg0: &mut Config, arg1: &0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::admin::AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_wl_only(arg0: &mut Config, arg1: &0x23f43e4ae6a50f04c15fc1035a72b5ec5b9cc60cf9c1a471da63cecf302a61d1::admin::AdminCap, arg2: bool) {
        arg0.wl_only = arg2;
    }

    // decompiled from Move bytecode v6
}

