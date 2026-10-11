module 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    struct Card has store, key {
        id: 0x2::object::UID,
        code: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun attributes(arg0: &Card) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public(friend) fun burn(arg0: Card) : 0x1::string::String {
        let Card {
            id            : v0,
            code          : v1,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            attributes    : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun code(arg0: &Card) : &0x1::string::String {
        &arg0.code
    }

    public fun description(arg0: &Card) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &Card) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CARD>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Card>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Card>(&mut v4, &v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Card>(&mut v4, &v3, 500, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Card>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Card>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Card {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Tier"), arg5);
        Card{
            id            : 0x2::object::new(arg6),
            code          : arg0,
            name          : arg1,
            description   : arg2,
            image_url     : arg3,
            thumbnail_url : arg4,
            attributes    : v0,
        }
    }

    public fun name(arg0: &Card) : &0x1::string::String {
        &arg0.name
    }

    public fun register_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<Card>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://cdn.litemint.com/cards/{code}.webp"));
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{thumbnail_url}"));
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://undercity.cyberbrawl.io/market/{code}"));
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://cyberbrawl.io"));
        0x2::display_registry::set<Card>(&mut v3, &v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Litemint"));
        0x2::display_registry::share<Card>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Card>>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun thumbnail_url(arg0: &Card) : &0x1::string::String {
        &arg0.thumbnail_url
    }

    // decompiled from Move bytecode v7
}

