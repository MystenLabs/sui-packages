module 0x4564ec2f2a5fb01c8d0ef4703e167f7c5984b7dde710f1f73470ac70057bfe12::pussui {
    struct PUSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSUI>(arg0, 6, b"PUSSUI", b"Pussui", b"$PUSSUI is a bold and provocative celebration of the feminine treasure, blending the strength and mystery of womanhood with the dynamism of the SUI network. This daring token is a tribute to autonomy, confidence, and freedom, highlighting the transformative power of femininity in all its forms. Like $PUSSUI, the feminine essence is unique, powerful, and capable of moving the world. With an irreverent and unapologetic attitude, $PUSSUI aims to shake up the memecoin market, drawing attention to the value of sensuality and feminine audacity in the crypto universe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/the_belgian_chocolate_makers_pussy_lollipop_deep_b_bb7eda7887.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

