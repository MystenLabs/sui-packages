module 0xcdb8214b56dbd982e54eddb506c9b3b19f61c1640eeb9ff0297558208f34a02e::grm {
    struct GRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRM>(arg0, 9, b"GRM", b"GREEN ", b"YAMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79659410-0cb9-4c63-ae4c-7ddb247b3de4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

