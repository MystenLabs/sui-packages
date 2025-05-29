module 0xd903248d9a11a7fb8d58e77d83ea4b2876a5c318a9786fbef1f4a8275ff6ebe::tsahur {
    struct TSAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSAHUR>(arg0, 9, b"TSAHUR", b"Tung Tung Sahur", b"Tung Tung Tung Sahur is an anomalous character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/64522b44077f58ee32d1e1dac5c301f9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSAHUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSAHUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

