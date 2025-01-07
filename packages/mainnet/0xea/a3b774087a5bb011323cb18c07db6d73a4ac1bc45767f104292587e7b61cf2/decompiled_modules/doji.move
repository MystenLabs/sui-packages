module 0xeaa3b774087a5bb011323cb18c07db6d73a4ac1bc45767f104292587e7b61cf2::doji {
    struct DOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJI>(arg0, 6, b"DOJI", b"Doji", x"49e280996d2061204d616c746573652064776f6720696e206120776f726c642066756c206f66206b6174732e204d692062696765737420696e73656375726974696920697320492063616ee2809974207370656c6c6c2c206275742066756b69742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730996614328.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOJI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

