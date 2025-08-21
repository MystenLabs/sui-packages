module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config {
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

    public(friend) fun init_render_config(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RenderConfig{
            id               : 0x2::object::new(arg1),
            authority_pubkey : 0x1::vector::empty<u8>(),
            base_url         : 0x1::string::utf8(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::render_base_url()),
        };
        0x2::transfer::share_object<RenderConfig>(v0);
    }

    public(friend) fun update_render_config(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::admin_cap::AdminCap, arg1: &mut RenderConfig, arg2: vector<u8>, arg3: 0x1::string::String) {
        arg1.authority_pubkey = arg2;
        arg1.base_url = arg3;
    }

    // decompiled from Move bytecode v6
}

