module 0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hardwareplay_tags {
    struct HARDWAREPLAY_TAGS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Tag has store, key {
        id: 0x2::object::UID,
        uid_hex: 0x1::string::String,
        nfc_tag_uid: 0x1::string::String,
        user_id: 0x1::string::String,
        created_by: address,
    }

    struct TagRegistered has copy, drop {
        tag_id: 0x2::object::ID,
        uid_hex: 0x1::string::String,
        nfc_tag_uid: 0x1::string::String,
        user_id: 0x1::string::String,
        owner_wallet: address,
        registrar: address,
    }

    struct TagTransferred has copy, drop {
        tag_id: 0x2::object::ID,
        from_wallet: address,
        to_wallet: address,
        by: address,
    }

    public fun admin_cap_id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::id<AdminCap>(arg0)
    }

    public fun created_by(arg0: &Tag) : address {
        arg0.created_by
    }

    fun init(arg0: HARDWAREPLAY_TAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = 0x2::package::claim<HARDWAREPLAY_TAGS>(arg0, arg1);
        let v3 = 0x2::display::new<Tag>(&v2, arg1);
        0x2::display::add<Tag>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"HardwarePlay Tag #{uid_hex}"));
        0x2::display::add<Tag>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"NFC tag registered on the HardwarePlay platform. UID: {uid_hex}"));
        0x2::display::add<Tag>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://hardwareplay.com/uploads/nft-tag-card.png"));
        0x2::display::add<Tag>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://hardwareplay.com"));
        0x2::display::update_version<Tag>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<Tag>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
    }

    public fun nfc_tag_uid(arg0: &Tag) : &0x1::string::String {
        &arg0.nfc_tag_uid
    }

    entry fun register_tag(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Tag{
            id          : 0x2::object::new(arg5),
            uid_hex     : arg1,
            nfc_tag_uid : arg2,
            user_id     : arg4,
            created_by  : v0,
        };
        let v2 = TagRegistered{
            tag_id       : 0x2::object::id<Tag>(&v1),
            uid_hex      : arg1,
            nfc_tag_uid  : arg2,
            user_id      : arg4,
            owner_wallet : arg3,
            registrar    : v0,
        };
        0x2::event::emit<TagRegistered>(v2);
        0x2::transfer::public_transfer<Tag>(v1, arg3);
    }

    entry fun transfer_tag(arg0: Tag, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = TagTransferred{
            tag_id      : 0x2::object::id<Tag>(&arg0),
            from_wallet : v0,
            to_wallet   : arg1,
            by          : v0,
        };
        0x2::event::emit<TagTransferred>(v1);
        0x2::transfer::public_transfer<Tag>(arg0, arg1);
    }

    public fun uid_hex(arg0: &Tag) : &0x1::string::String {
        &arg0.uid_hex
    }

    public fun user_id(arg0: &Tag) : &0x1::string::String {
        &arg0.user_id
    }

    // decompiled from Move bytecode v7
}

