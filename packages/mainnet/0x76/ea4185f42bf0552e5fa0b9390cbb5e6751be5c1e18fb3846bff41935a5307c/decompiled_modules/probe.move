module 0x76ea4185f42bf0552e5fa0b9390cbb5e6751be5c1e18fb3846bff41935a5307c::probe {
    struct PROBE has drop {
        dummy_field: bool,
    }

    struct ProbeAsset has store, key {
        id: 0x2::object::UID,
        label: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: PROBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PROBE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{label}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"gallery"));
        let v5 = 0x2::display::new_with_fields<ProbeAsset>(&v0, v1, v3, arg1);
        0x2::display::update_version<ProbeAsset>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ProbeAsset>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ProbeAsset{
            id          : 0x2::object::new(arg4),
            label       : arg1,
            description : arg2,
            image_url   : arg3,
        };
        0x2::transfer::public_transfer<ProbeAsset>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

