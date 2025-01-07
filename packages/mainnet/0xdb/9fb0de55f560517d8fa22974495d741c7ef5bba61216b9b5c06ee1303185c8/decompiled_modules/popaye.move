module 0xdb9fb0de55f560517d8fa22974495d741c7ef5bba61216b9b5c06ee1303185c8::popaye {
    struct POPAYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPAYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPAYE>(arg0, 6, b"Popaye", b"Popaye The Suilorman", x"506f7061796520546865205375696c6f726d616e0a0a524541445920544f2042452054484520204e455854204d455441204f4e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilorman_d7a4b3895f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPAYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPAYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

