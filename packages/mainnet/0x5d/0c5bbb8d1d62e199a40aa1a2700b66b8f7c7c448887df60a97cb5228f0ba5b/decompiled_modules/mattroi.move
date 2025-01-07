module 0x5d0c5bbb8d1d62e199a40aa1a2700b66b8f7c7c448887df60a97cb5228f0ba5b::mattroi {
    struct MATTROI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATTROI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATTROI>(arg0, 9, b"MATTROI", b"sunshine", b"choiloa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f6c439e-a2ce-4320-b213-15ff99693c14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATTROI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATTROI>>(v1);
    }

    // decompiled from Move bytecode v6
}

