module 0xaf88ad22183ae4125a4406cb223a4b9b02ba037ab2052ac84dcb084386a61993::TRUMP {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"Donald Trump", b"TRUMP", b"A meme coin that's gonna make crypto great again! No walls, just gains. HODL for the ultimate MAGA rally!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/diPGJXO2R64IJFlnZybs05951JcPd8JTXAm7k8fdSgrYyfFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

