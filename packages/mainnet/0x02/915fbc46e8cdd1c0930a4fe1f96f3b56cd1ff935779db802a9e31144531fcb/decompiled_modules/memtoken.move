module 0x2915fbc46e8cdd1c0930a4fe1f96f3b56cd1ff935779db802a9e31144531fcb::memtoken {
    struct MEMTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMTOKEN>(arg0, 9, b"MEMTOKEN", b"STM ", b"STM MEMTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61d6bcff-2464-4e1a-ae63-a1870dd8f670.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

