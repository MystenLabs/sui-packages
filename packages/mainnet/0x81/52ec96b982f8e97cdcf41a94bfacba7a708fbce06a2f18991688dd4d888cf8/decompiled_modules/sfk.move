module 0x8152ec96b982f8e97cdcf41a94bfacba7a708fbce06a2f18991688dd4d888cf8::sfk {
    struct SFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFK>(arg0, 6, b"SFK", b"SunFucker", b"Am here to tak ova dis shiz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914001115_e3f68a16a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

