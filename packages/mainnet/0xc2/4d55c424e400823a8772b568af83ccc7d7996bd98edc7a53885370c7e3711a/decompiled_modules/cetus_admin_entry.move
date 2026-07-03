module 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_admin_entry {
    public fun register_cetus_hasui_leg_auth<T0>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::LLVGlobal, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::assert_version(arg0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::register_protocol_leg_auth<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::LLVGlobal, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::assert_version(arg0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, 0xc24d55c424e400823a8772b568af83ccc7d7996bd98edc7a53885370c7e3711a::cetus_entry::CetusLegAuth>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
    }

    // decompiled from Move bytecode v7
}

