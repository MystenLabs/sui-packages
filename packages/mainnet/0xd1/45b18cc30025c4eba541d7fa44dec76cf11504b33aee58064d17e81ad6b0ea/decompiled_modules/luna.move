module 0xd145b18cc30025c4eba541d7fa44dec76cf11504b33aee58064d17e81ad6b0ea::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"Luna the Little Leopard", b"Pounce in early, or watch me sprint past!  Im Luna the Little Leopard, here to dominate SUI. Dont miss your chance to run with the best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_2024_10_05_at_2_24a_AM_87630bf76b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

