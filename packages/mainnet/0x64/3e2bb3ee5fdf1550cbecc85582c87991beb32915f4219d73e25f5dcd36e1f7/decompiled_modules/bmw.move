module 0x643e2bb3ee5fdf1550cbecc85582c87991beb32915f4219d73e25f5dcd36e1f7::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMW>(arg0, 6, b"BMW", b"Bmw", b"Fuck this sui meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749377382110.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

