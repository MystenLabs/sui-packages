module 0x3ec6ce68d6a543554fec13685b4049da02c94e18623296ede0009c13f7abb208::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"Poop Frog", x"506f6f702046726f67206c696b657320746f2074616b652061207368697420616e7977686572652c20616e7974696d652e0a48652064726f7073206d6f7265207475726473207468616e20656767732e0a526561647920746f206469766520696e746f20746865206372617a696573742063727970746f207377616d703f0a24504f4f50206d616b65732061206d657373206275742074686973207368697473746f726d206d6967687420706179206f6666206269672021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010489_8f4f87c6e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

