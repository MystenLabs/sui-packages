module 0xb62328f686315f48759811256e5935d5437f38b3779437fe61ede0c675b88cdd::meizhu {
    struct MEIZHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEIZHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEIZHU>(arg0, 6, b"MEIZHU", b"GUANGHZOU ZOO NEW BABY PANDA", b"The viral internet sensation in China, MEIZHU baby panda from Guanghzou Zoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1002_2f900d26f2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEIZHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEIZHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

