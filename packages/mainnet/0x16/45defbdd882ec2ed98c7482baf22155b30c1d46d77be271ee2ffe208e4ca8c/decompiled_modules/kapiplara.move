module 0x1645defbdd882ec2ed98c7482baf22155b30c1d46d77be271ee2ffe208e4ca8c::kapiplara {
    struct KAPIPLARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPIPLARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPIPLARA>(arg0, 6, b"KAPIPLARA", b"KAPI", b"KAPI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_03_03_09_8877333d20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPIPLARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAPIPLARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

