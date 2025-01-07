module 0x173d149b79a7bb6dd8fe37d4ab731825c12d8031ba093cf6488fde61a3decccb::rw {
    struct RW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RW>(arg0, 9, b"RW", b"Rekavery w", b"Rekavery wikle token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d30af688-39cf-4b23-9ce4-9d137820de1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RW>>(v1);
    }

    // decompiled from Move bytecode v6
}

