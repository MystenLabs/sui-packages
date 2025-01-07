module 0x6b927566d29c3da699b3be6469e2ddf7f2c9634a4e9cfb22345aaf893cdf4b58::funnyv2 {
    struct FUNNYV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNYV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNYV2>(arg0, 6, b"FUNNYv2", b"Funny The Bunny v2", b"A new dawn...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731019919888.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNYV2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNYV2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

