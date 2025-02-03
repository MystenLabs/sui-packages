module 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::pandorian_box {
    struct PANDORIAN_BOX has drop {
        dummy_field: bool,
    }

    struct PandorianBox has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        slot_no: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PandorianBox{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Pandorian Box"),
            description : 0x1::string::utf8(b"Pandorian Box will be used to claim Pandorian NFT after the mint event ends."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmaiUywdJQENtQnPwichBErkyHZpWy7DtHm8zraj3B7ccZ"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://app.pandorafi.xyz/pandorian-mint"),
            slot_no     : arg0,
        };
        0x2::transfer::transfer<PandorianBox>(v0, 0x2::tx_context::sender(arg1));
        0x2::object::id<PandorianBox>(&v0)
    }

    public(friend) fun burn(arg0: PandorianBox) {
        let PandorianBox {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            slot_no     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: PANDORIAN_BOX, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<PANDORIAN_BOX>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PandorianBox>(&v4, v0, v2, arg1);
        0x2::display::update_version<PandorianBox>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PandorianBox>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

