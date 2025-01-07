module 0x2e218a365e0265b26eb3b58d1c3e116c2a158d913a388df0ee4d8aa9a1e17bc7::tated {
    struct TATED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATED>(arg0, 6, b"TateD", b"DaddyTATE", b"Let's fucking go ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7243_1173a22c4c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATED>>(v1);
    }

    // decompiled from Move bytecode v6
}

