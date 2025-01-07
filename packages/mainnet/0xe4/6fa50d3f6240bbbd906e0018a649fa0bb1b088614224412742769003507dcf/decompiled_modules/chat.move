module 0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::chat {
    struct Chat has store, key {
        id: 0x2::object::UID,
        app_id: address,
        text: 0x1::ascii::String,
        ref_id: 0x1::option::Option<address>,
        metadata: vector<u8>,
    }

    public entry fun burn(arg0: Chat) {
        let Chat {
            id       : v0,
            app_id   : _,
            text     : _,
            ref_id   : _,
            metadata : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun post(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        post_internal(arg0, arg1, 0x1::option::none<address>(), arg2, arg3);
    }

    fun post_internal(arg0: address, arg1: vector<u8>, arg2: 0x1::option::Option<address>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) <= 512, 0);
        let v0 = Chat{
            id       : 0x2::object::new(arg4),
            app_id   : arg0,
            text     : 0x1::ascii::string(arg1),
            ref_id   : arg2,
            metadata : arg3,
        };
        0x2::transfer::public_transfer<Chat>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun post_with_ref(arg0: address, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        post_internal(arg0, arg1, 0x1::option::some<address>(arg2), arg3, arg4);
    }

    public fun text(arg0: &Chat) : 0x1::ascii::String {
        arg0.text
    }

    // decompiled from Move bytecode v6
}

