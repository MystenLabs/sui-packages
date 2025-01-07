module 0xb8a093daec05c85a058a856b438f49115b36de9773adec7912e8db8802f4b6e2::liq {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ>(arg0, 6, b"LIQ", b"Liquor", b"Be liquor, my friend. New era of meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731079832425.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

