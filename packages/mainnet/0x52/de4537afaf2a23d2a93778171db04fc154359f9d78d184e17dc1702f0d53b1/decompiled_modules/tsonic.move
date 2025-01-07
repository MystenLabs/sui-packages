module 0x52de4537afaf2a23d2a93778171db04fc154359f9d78d184e17dc1702f0d53b1::tsonic {
    struct TSONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSONIC>(arg0, 6, b"Tsonic", b"Turbosonic", b"welcome to the world of speed with the fastest memecoin on Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731417962176.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSONIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSONIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

