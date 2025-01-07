module 0x1531584a6027c95ce1b10c6364d30c7ee29ad7c6fb63644a8e9fa6097bf3b7e5::hole {
    struct HOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLE>(arg0, 9, b"HOLE", b"Hole", b"Hole is a MeMeCoiN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77088edf-8b7d-4125-b5e5-5447d1b44c2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

