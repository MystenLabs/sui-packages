module 0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::entry {
    struct ENTRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ENTRY>(arg0, arg1);
        let v2 = 0x2::display::new<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&v1, arg1);
        0x2::display::add<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"author"), 0x1::string::utf8(b"{author}"));
        0x2::display::add<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"id_number"), 0x1::string::utf8(b"{id_number}"));
        0x2::display::add<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::update_version<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::Collectible>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::admin_cap::transfer_to(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::admin_cap::init_admin_cap(arg1), v0);
    }

    entry fun mint(arg0: &0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::admin_cap::AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::transfer_to(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible::new(arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

