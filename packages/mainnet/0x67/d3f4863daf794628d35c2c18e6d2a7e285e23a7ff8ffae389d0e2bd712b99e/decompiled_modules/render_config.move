module 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::render_config {
    struct RenderConfig has key {
        id: 0x2::object::UID,
        authority_pubkey: vector<u8>,
        base_url: 0x1::string::String,
    }

    public(friend) fun authority_pubkey(arg0: &RenderConfig) : &vector<u8> {
        &arg0.authority_pubkey
    }

    public(friend) fun base_url(arg0: &RenderConfig) : &0x1::string::String {
        &arg0.base_url
    }

    public(friend) fun init_render_config(arg0: &0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RenderConfig{
            id               : 0x2::object::new(arg1),
            authority_pubkey : 0x1::vector::empty<u8>(),
            base_url         : 0x1::string::utf8(0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::constants::render_base_url()),
        };
        0x2::transfer::share_object<RenderConfig>(v0);
    }

    public(friend) fun update_render_config(arg0: &0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::admin_cap::AdminCap, arg1: &mut RenderConfig, arg2: vector<u8>, arg3: 0x1::string::String) {
        arg1.authority_pubkey = arg2;
        arg1.base_url = arg3;
    }

    // decompiled from Move bytecode v6
}

