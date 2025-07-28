module 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::render_config {
    struct RenderConfig has key {
        id: 0x2::object::UID,
        authority_pubkey: vector<u8>,
        base_url: 0x1::string::String,
    }

    public fun authority_pubkey(arg0: &RenderConfig) : &vector<u8> {
        &arg0.authority_pubkey
    }

    public(friend) fun authority_pubkey_mut(arg0: &mut RenderConfig) : &mut vector<u8> {
        &mut arg0.authority_pubkey
    }

    public fun base_url(arg0: &RenderConfig) : &0x1::string::String {
        &arg0.base_url
    }

    public(friend) fun base_url_mut(arg0: &mut RenderConfig) : &mut 0x1::string::String {
        &mut arg0.base_url
    }

    public fun init_render_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RenderConfig{
            id               : 0x2::object::new(arg0),
            authority_pubkey : 0x1::vector::empty<u8>(),
            base_url         : 0x1::string::utf8(b"https://megawavesmakers.com:3371/"),
        };
        0x2::transfer::share_object<RenderConfig>(v0);
    }

    public entry fun update_authority_pubkey(arg0: &0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::admin_cap::AdminCap, arg1: &mut RenderConfig, arg2: vector<u8>) {
        arg1.authority_pubkey = arg2;
    }

    public entry fun update_base_url(arg0: &0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::admin_cap::AdminCap, arg1: &mut RenderConfig, arg2: 0x1::string::String) {
        arg1.base_url = arg2;
    }

    public entry fun update_render_config(arg0: &0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::admin_cap::AdminCap, arg1: &mut RenderConfig, arg2: vector<u8>, arg3: 0x1::string::String) {
        arg1.authority_pubkey = arg2;
        arg1.base_url = arg3;
    }

    // decompiled from Move bytecode v6
}

