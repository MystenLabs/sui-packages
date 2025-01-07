module 0x25b6ffc43e44a52c361061d87b0c86911aa452f978f65b60b2c8df0b6c08953f::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"WOJAK", b"WOJAK ON SUI", x"574f4a414b204f4e2053554920200a0a3130302520434f4d4d554e4954592044524956454e20200a0a4e4f2057454253495445200a4e4f2054574954544552200a4f4e4c5920544720434841445320414c4c4f574544", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/teen_wolf_image_1_ce0437e26f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

