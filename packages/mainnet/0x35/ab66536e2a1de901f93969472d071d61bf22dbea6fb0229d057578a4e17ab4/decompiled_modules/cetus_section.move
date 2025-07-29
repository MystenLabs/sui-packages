module 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::cetus_section {
    struct CetusConfig has store, key {
        id: 0x2::object::UID,
        active: bool,
        globalConfig: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig,
        partner: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner,
    }

    public(friend) fun new_cetus(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusConfig{
            id           : 0x2::object::new(arg2),
            active       : true,
            globalConfig : arg0,
            partner      : arg1,
        };
        0x2::transfer::share_object<CetusConfig>(v0);
    }

    public fun swap_hasui_sui(arg0: &mut CetusConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(&arg0.globalConfig, arg1, &mut arg0.partner, arg2, arg3, arg4)
    }

    public fun swap_vsui_sui(arg0: &mut CetusConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0.globalConfig, arg1, &mut arg0.partner, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

