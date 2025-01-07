module 0xfdcd3d6ec3325d27c3ee71b29ce9b7a264c1caf6eef09a8f40922137f13df9ba::wtc {
    struct WTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTC>(arg0, 6, b"WTC", b"watercat", b"Dive into the perfect meme token on the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965443404.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

