module 0x644df1655a6f7403425955eff03e76c3373882dbf97c716691d5f559766822cc::atlansui_lab {
    struct ATLANSUI_LAB has drop {
        dummy_field: bool,
    }

    struct AtlansuiLab has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        slot_no: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AtlansuiLab{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Atlansui Lab"),
            description : 0x1::string::utf8(b"Atlansui Lab will be used to claim Atlansui NFT after the mint event ends."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreib2rahqldelfcmoi6tc3y5mxri4acjeunpnebxef5nejseq2s5ble"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://atlansui.xyz/"),
            slot_no     : arg0,
        };
        0x2::transfer::transfer<AtlansuiLab>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun burn(arg0: AtlansuiLab) {
        let AtlansuiLab {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            slot_no     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_slot_no(arg0: &AtlansuiLab) : u64 {
        arg0.slot_no
    }

    fun init(arg0: ATLANSUI_LAB, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<ATLANSUI_LAB>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AtlansuiLab>(&v4, v0, v2, arg1);
        0x2::display::update_version<AtlansuiLab>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AtlansuiLab>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

