module 0x3e4c98b0b86cf37fb2e6ac3ba3406811ce72eaddda1b961cd989a2c9e970c3fe::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"Candy", b"Candy Coin", b"The sweetest memecoin on Sui, bringing fun, community, and moon-worthy vibes! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gkx95_H_W8_AAH_6_BI_cd327bed5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

