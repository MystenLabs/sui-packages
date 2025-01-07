module 0xe68fe3da38875c32443f09544f19398ad37bf5b0cdf6ba338c6ff27b9249199a::jacob {
    struct JACOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACOB>(arg0, 6, b"JACOB", b"Jacob", b"The richest animal on Sui. Projacobly nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5534_46012ca9a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

