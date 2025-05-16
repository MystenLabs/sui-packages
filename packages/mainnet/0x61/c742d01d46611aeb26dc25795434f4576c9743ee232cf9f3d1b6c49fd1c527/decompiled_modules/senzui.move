module 0x61c742d01d46611aeb26dc25795434f4576c9743ee232cf9f3d1b6c49fd1c527::senzui {
    struct SENZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENZUI>(arg0, 6, b"SENZUI", b"Senzui", b"Cyber Samurai. Liquid Spirit. Powered by SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091584_7d5362d926.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENZUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

