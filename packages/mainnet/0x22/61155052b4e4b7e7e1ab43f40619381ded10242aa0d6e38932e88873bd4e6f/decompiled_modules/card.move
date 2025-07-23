module 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    struct Card has store, key {
        id: 0x2::object::UID,
        card_id: 0x1::string::String,
        card_template_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        obtained_at: u64,
        source_pack_id: 0x1::option::Option<0x2::object::ID>,
        metadata: 0x1::string::String,
    }

    public(friend) fun description(arg0: &Card) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_card_id(arg0: &Card) : 0x1::string::String {
        arg0.card_id
    }

    public fun get_card_template_id(arg0: &Card) : 0x2::object::ID {
        arg0.card_template_id
    }

    public(friend) fun image_url(arg0: &Card) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CARD>(arg0, arg1);
        let v1 = 0x2::display::new<Card>(&v0, arg1);
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"card_id"), 0x1::string::utf8(b"{card_id}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.projectj-tcg.com"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"metadata"), 0x1::string::utf8(b"{metadata}"));
        0x2::display::update_version<Card>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Card>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun metadata(arg0: &Card) : 0x1::string::String {
        arg0.metadata
    }

    public(friend) fun mint_card(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &mut 0x2::tx_context::TxContext) : Card {
        Card{
            id               : 0x2::object::new(arg9),
            card_id          : arg0,
            card_template_id : arg1,
            name             : arg2,
            description      : arg3,
            image_url        : arg4,
            url              : arg5,
            obtained_at      : arg7,
            source_pack_id   : arg8,
            metadata         : arg6,
        }
    }

    public(friend) fun name(arg0: &Card) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun obtained_at(arg0: &Card) : u64 {
        arg0.obtained_at
    }

    public(friend) fun source_pack_id(arg0: &Card) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source_pack_id
    }

    public(friend) fun url(arg0: &Card) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

