module 0x9445f944b3848cad7423d5ac724a52446c42c5816fae39e3ff62eef1adf8887e::splat {
    struct SPLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLAT>(arg0, 6, b"SPLAT", b"Sui Splat", b"Splat is umtimate memecoin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250509_004022_4a26c5884d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

