module 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::mystic_yeti {
    struct MysticYetiData has store {
        number: u64,
        image_url: 0x1::string::String,
        attributes: 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::attributes::Attributes,
    }

    struct MysticYeti has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        number: u64,
        image_url: 0x1::string::String,
        attributes: 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::attributes::Attributes,
    }

    struct RevealData has key {
        id: 0x2::object::UID,
        number: u64,
        image_url: 0x1::string::String,
        attributes: 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::attributes::Attributes,
    }

    public(friend) fun attributes(arg0: &MysticYeti) : 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::attributes::Attributes {
        arg0.attributes
    }

    public(friend) fun admin_new_mystic_yeti(arg0: MysticYetiData, arg1: &mut 0x2::tx_context::TxContext) : MysticYeti {
        let MysticYetiData {
            number     : v0,
            image_url  : v1,
            attributes : v2,
        } = arg0;
        let v3 = 0x2::object::new(arg1);
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::lofinfts_events::mint(0x2::object::uid_to_inner(&v3), v0);
        let v4 = 0x1::string::utf8(b"Mystic Yeti #");
        0x1::string::append(&mut v4, 0x1::u64::to_string(v0));
        MysticYeti{
            id         : v3,
            name       : v4,
            number     : v0,
            image_url  : v1,
            attributes : v2,
        }
    }

    public(friend) fun image_url(arg0: &MysticYeti) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun new_mystic_yeti(arg0: MysticYetiData, arg1: &mut 0x2::tx_context::TxContext) : MysticYeti {
        let MysticYetiData {
            number     : v0,
            image_url  : v1,
            attributes : v2,
        } = arg0;
        let v3 = MysticYeti{
            id         : 0x2::object::new(arg1),
            name       : 0x1::string::utf8(b"Mystic Yeti Frozen"),
            number     : v0,
            image_url  : 0x1::string::utf8(b"https://raw.githubusercontent.com/Iamknownasfesal/lofi-image/refs/heads/main/frozen_yeti.jpg"),
            attributes : 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::attributes::empty(),
        };
        let v4 = RevealData{
            id         : 0x2::object::new(arg1),
            number     : v0,
            image_url  : v1,
            attributes : v2,
        };
        0x2::transfer::transfer<RevealData>(v4, 0x2::object::uid_to_address(&v3.id));
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::lofinfts_events::mint(*0x2::object::uid_as_inner(&v3.id), v0);
        v3
    }

    public(friend) fun new_mystic_yeti_data(arg0: u64, arg1: 0x1::string::String, arg2: 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::attributes::Attributes) : MysticYetiData {
        MysticYetiData{
            number     : arg0,
            image_url  : arg1,
            attributes : arg2,
        }
    }

    public(friend) fun number(arg0: &MysticYeti) : u64 {
        arg0.number
    }

    public(friend) fun reveal_mystic_yeti(arg0: &mut MysticYeti, arg1: 0x2::transfer::Receiving<RevealData>) {
        let RevealData {
            id         : v0,
            number     : v1,
            image_url  : v2,
            attributes : v3,
        } = 0x2::transfer::receive<RevealData>(&mut arg0.id, arg1);
        let v4 = 0x1::string::utf8(b"Mystic Yeti #");
        0x1::string::append(&mut v4, 0x1::u64::to_string(v1));
        arg0.name = v4;
        arg0.image_url = v2;
        arg0.attributes = v3;
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::lofinfts_events::reveal(*0x2::object::uid_as_inner(&arg0.id), arg0.number);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

