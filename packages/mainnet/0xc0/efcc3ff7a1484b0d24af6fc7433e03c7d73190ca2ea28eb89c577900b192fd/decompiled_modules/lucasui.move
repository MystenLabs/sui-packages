module 0xc0efcc3ff7a1484b0d24af6fc7433e03c7d73190ca2ea28eb89c577900b192fd::lucasui {
    struct LUCASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCASUI>(arg0, 6, b"Lucasui", b"Lucas", b"Lucas - Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029171_37dc2ff737.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

