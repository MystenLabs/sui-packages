module 0x59abb08f85bbc43193eb10bd0f6061cf7f2469e54695e20c26cf9c5e451c7cbb::xoe629nstw {
    struct XOE629NSTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: XOE629NSTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XOE629NSTW>(arg0, 9, b"XOE629NSTW", b"Mismala", b"A coins with liquidity best project ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d478b729-33b6-4176-b34d-b97959755643.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XOE629NSTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XOE629NSTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

