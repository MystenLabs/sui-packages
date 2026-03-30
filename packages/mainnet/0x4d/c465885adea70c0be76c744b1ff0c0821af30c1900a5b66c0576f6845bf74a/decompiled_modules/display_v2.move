module 0x4dc465885adea70c0be76c744b1ff0c0821af30c1900a5b66c0576f6845bf74a::display_v2 {
    struct DemoBear has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DemoBear{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Haha"),
        };
        0x2::transfer::public_transfer<DemoBear>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun setup_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new<DemoBear>(arg0, 0x1::internal::permit<DemoBear>(), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<DemoBear>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"My name is {name}"));
        0x2::display_registry::set<DemoBear>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This is a demo bear description for: {id}"));
        0x2::display_registry::set<DemoBear>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Demo Bears"));
        0x2::display_registry::set<DemoBear>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://t3.ftcdn.net/jpg/03/81/74/14/360_F_381741494_zYzlnX1N7wBQcX0RzzUB7Se5omIIIDT7.jpg"));
        0x2::display_registry::share<DemoBear>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<DemoBear>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

