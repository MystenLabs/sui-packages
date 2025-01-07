module 0xd0018c69036a3f0d9b70fa5b333a03d54e65c4ecb14860ffe2803c4d299f7819::spt {
    struct SPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPT>(arg0, 6, b"SPT", b"SunfishPepeToken", b"Dive into the meme-tastic ocean with SunfishPepeToken (SPT), the cryptocurrency that captures the essence of the internet's favorite goofy fish. A hyper-deflationary token with a low initial supply and a high burn rate, SPT offers the potential for s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731382144459.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

