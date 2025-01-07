module 0xe28819ac2d8300d87153381682c8d82f836f79af873d0ddda8f15a4295de941b::soy {
    struct SOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOY>(arg0, 6, b"SOY", b"Soy Coin", b"$SOY is the fcking ultimate meme icon, blasting onto SUI with turbocharged speed and zero fcking gas fees", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731748155934.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

