module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::whitelist {
    struct MoomeWhitelistRecord has drop, store {
        coin_a_type: 0x1::ascii::String,
        coin_b_type: 0x1::ascii::String,
        fee_type: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        meta: vector<u8>,
    }

    struct MoomeWhitelist has store, key {
        id: 0x2::object::UID,
        whitelisted: vector<MoomeWhitelistRecord>,
        meta: vector<u8>,
    }

    public(friend) fun forget(arg0: &mut MoomeWhitelist, arg1: 0x2::object::ID) {
        if (is_whitelisted(arg0, arg1)) {
            let v0 = 0;
            let v1 = 0;
            while (v0 < 0x1::vector::length<MoomeWhitelistRecord>(&arg0.whitelisted) && v1 == 0) {
                if (0x1::vector::borrow<MoomeWhitelistRecord>(&arg0.whitelisted, v0).pool_id == arg1) {
                    v1 = v0 + 1;
                };
                v0 = v0 + 1;
            };
            if (v1 > 0) {
                0x1::vector::swap_remove<MoomeWhitelistRecord>(&mut arg0.whitelisted, v1 - 1);
            };
        };
    }

    public(friend) fun is_whitelisted(arg0: &MoomeWhitelist, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<MoomeWhitelistRecord>(&arg0.whitelisted)) {
            if (0x1::vector::borrow<MoomeWhitelistRecord>(&arg0.whitelisted, v0).pool_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun make(arg0: &mut 0x2::tx_context::TxContext) : MoomeWhitelist {
        MoomeWhitelist{
            id          : 0x2::object::new(arg0),
            whitelisted : 0x1::vector::empty<MoomeWhitelistRecord>(),
            meta        : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun whitelist_cetus<T0, T1>(arg0: &mut MoomeWhitelist, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<u8>) {
        if (!is_whitelisted(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1))) {
            let v0 = MoomeWhitelistRecord{
                coin_a_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                coin_b_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
                fee_type    : 0x1::ascii::string(b""),
                pool_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
                meta        : arg2,
            };
            0x1::vector::push_back<MoomeWhitelistRecord>(&mut arg0.whitelisted, v0);
        };
    }

    public(friend) fun whitelist_turbos<T0, T1>(arg0: &mut MoomeWhitelist, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: vector<u8>) {
        if (!is_whitelisted(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg1))) {
            let v0 = MoomeWhitelistRecord{
                coin_a_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                coin_b_type : 0x1::ascii::string(b""),
                fee_type    : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
                pool_id     : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg1),
                meta        : arg2,
            };
            0x1::vector::push_back<MoomeWhitelistRecord>(&mut arg0.whitelisted, v0);
        };
    }

    // decompiled from Move bytecode v6
}

