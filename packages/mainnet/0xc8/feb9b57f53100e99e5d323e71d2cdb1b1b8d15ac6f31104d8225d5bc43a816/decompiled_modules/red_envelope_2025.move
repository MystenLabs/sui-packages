module 0xc8feb9b57f53100e99e5d323e71d2cdb1b1b8d15ac6f31104d8225d5bc43a816::red_envelope_2025 {
    struct RED_ENVELOPE_2025 has drop {
        dummy_field: bool,
    }

    struct RedEnvelope has store, key {
        id: 0x2::object::UID,
        kind: u8,
    }

    public fun new(arg0: &0xc8feb9b57f53100e99e5d323e71d2cdb1b1b8d15ac6f31104d8225d5bc43a816::admin::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : RedEnvelope {
        RedEnvelope{
            id   : 0x2::object::new(arg2),
            kind : arg1,
        }
    }

    public fun batch_create_to(arg0: &0xc8feb9b57f53100e99e5d323e71d2cdb1b1b8d15ac6f31104d8225d5bc43a816::admin::AdminCap, arg1: u8, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            create_to(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public fun create_to(arg0: &0xc8feb9b57f53100e99e5d323e71d2cdb1b1b8d15ac6f31104d8225d5bc43a816::admin::AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<RedEnvelope>(new(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RED_ENVELOPE_2025, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BuckYou Red Envelope 2025"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Go claim your shares at https://cny.buckyou.io !"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/Qmeyz3FijdgyR9AMqg84nzpQR4sXbZd1M4UBhQ9Dz99sYE"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cny.buckyou.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"buckyou"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<RED_ENVELOPE_2025>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<RedEnvelope>(&v5, v0, v2, arg1);
        0x2::display::update_version<RedEnvelope>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<RedEnvelope>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
    }

    // decompiled from Move bytecode v6
}

