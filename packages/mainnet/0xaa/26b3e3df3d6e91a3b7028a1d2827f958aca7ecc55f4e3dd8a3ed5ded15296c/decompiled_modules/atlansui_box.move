module 0xaa26b3e3df3d6e91a3b7028a1d2827f958aca7ecc55f4e3dd8a3ed5ded15296c::atlansui_box {
    struct ATLANSUI_BOX has drop {
        dummy_field: bool,
    }

    struct AtlansuiBox has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        slot_no: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AtlansuiBox{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Atlansui Box"),
            description : 0x1::string::utf8(b"Atlansui Box will be used to claim Atlansui NFT after the mint event ends."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmaiUywdJQENtQnPwichBErkyHZpWy7DtHm8zraj3B7ccZ"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://atlansui.xyz/"),
            slot_no     : arg0,
        };
        0x2::transfer::transfer<AtlansuiBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun burn(arg0: AtlansuiBox) {
        let AtlansuiBox {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            slot_no     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_slot_no(arg0: &AtlansuiBox) : u64 {
        arg0.slot_no
    }

    fun init(arg0: ATLANSUI_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"slot_no"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{slot_no}"));
        let v4 = 0x2::package::claim<ATLANSUI_BOX>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AtlansuiBox>(&v4, v0, v2, arg1);
        0x2::display::update_version<AtlansuiBox>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AtlansuiBox>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

