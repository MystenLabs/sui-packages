module 0x8e764fced5ad26e4466e693b69df73445492dccac1cb292ce141c69bd897ff16::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"Suib", b"Sui Butter", b"Sui Butter Reborn :Dive into the wild world of SUI Blue Butt , the memecoin on Sui for laughs, gains, and pure degen energy .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_c3578ff263.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

