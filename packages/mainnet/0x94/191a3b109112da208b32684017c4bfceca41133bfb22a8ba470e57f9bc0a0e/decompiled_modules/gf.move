module 0x94191a3b109112da208b32684017c4bfceca41133bfb22a8ba470e57f9bc0a0e::gf {
    struct GF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GF>(arg0, 9, b"GF", b"RTY", b"GFFGVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdaad7a9-1f8a-41bb-961d-81b8bcc5c250.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GF>>(v1);
    }

    // decompiled from Move bytecode v6
}

