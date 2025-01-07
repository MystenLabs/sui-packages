module 0x5a654091decf971f7526ee5f51277b3533852c75ef3046e89c5f2815e4f0ae1e::wz {
    struct WZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZ>(arg0, 9, b"WZ", b"WIZZWOODS", b"Community first ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1cde2c24-8520-41da-862b-d904443beb46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

