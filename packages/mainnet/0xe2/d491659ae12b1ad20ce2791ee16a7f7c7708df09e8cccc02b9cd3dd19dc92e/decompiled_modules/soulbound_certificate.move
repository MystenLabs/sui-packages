module 0xe2d491659ae12b1ad20ce2791ee16a7f7c7708df09e8cccc02b9cd3dd19dc92e::soulbound_certificate {
    struct SoulboundCertificate has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        event: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun init_display(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"event"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{event}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        let v2 = 0x2::display::new_with_fields<SoulboundCertificate>(arg0, v0, v1, arg1);
        0x2::display::update_version<SoulboundCertificate>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<SoulboundCertificate>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SoulboundCertificate{
            id        : 0x2::object::new(arg4),
            name      : arg1,
            event     : arg2,
            image_url : arg3,
        };
        0x2::transfer::transfer<SoulboundCertificate>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

