module 0x9a99769f351110c8f29da2abf23c0180479db99afbf485f730766a803aa5a4f2::arb {
    struct ARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARB>(arg0, 9, b"ARB", b"Arab", b"Community token for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcebd9a0-3c33-4ffd-85e5-0f8d939fe36d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARB>>(v1);
    }

    // decompiled from Move bytecode v6
}

