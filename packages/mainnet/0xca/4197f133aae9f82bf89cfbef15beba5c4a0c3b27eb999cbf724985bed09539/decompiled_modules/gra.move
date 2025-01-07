module 0xca4197f133aae9f82bf89cfbef15beba5c4a0c3b27eb999cbf724985bed09539::gra {
    struct GRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRA>(arg0, 6, b"Gra", b"GraFun", b"Let's GraFun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1904_d736ea925e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

