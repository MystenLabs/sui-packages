module 0xdbeb6f9ca23b3b2151715199e09799bde81a44460ad922465947c76bb3f23b38::benji {
    struct BENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJI>(arg0, 6, b"BENJI", b"Benji on SUI", b"I'm Taylor Swift's Cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Yuc_D_Bjm_400x400_9d23d1c84f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

