module 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon {
    struct Card has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        hash: vector<u8>,
        revealed: bool,
    }

    public(friend) fun burn_card(arg0: Card, arg1: bool) {
        if (arg1) {
            assert!(arg0.revealed, 3);
        };
        let Card {
            id          : v0,
            name        : _,
            description : _,
            media_url   : _,
            attributes  : _,
            hash        : _,
            revealed    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun init_card_type(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<Card>, 0x2::transfer_policy::TransferPolicyCap<Card>) {
        let v0 = 0x2::display::new<Card>(arg0, arg1);
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"{collection_name}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"{collection_description}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"{collection_media_url}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Card>(&mut v0, 0x1::string::utf8(b"hash"), 0x1::string::utf8(b"{hash}"));
        0x2::display::update_version<Card>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<Card>>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::transfer_policy::new<Card>(arg0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Card>(&mut v4, &v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Card>(&mut v4, &v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Card>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Card>>(v4);
        0x2::transfer_policy::new<Card>(arg0, arg1)
    }

    public(friend) fun mint_card(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: vector<u8>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : Card {
        Card{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            media_url   : arg2,
            attributes  : arg3,
            hash        : arg4,
            revealed    : arg5,
        }
    }

    public(friend) fun reveal_card(arg0: &mut Card, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: vector<u8>) {
        assert!(arg0.hash == arg5, 1);
        assert!(!arg0.revealed, 2);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.media_url = arg3;
        arg0.attributes = arg4;
        arg0.revealed = true;
    }

    // decompiled from Move bytecode v7
}

