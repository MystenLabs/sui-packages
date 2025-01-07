module 0x20b47afa7f677d1dace61669bed8ac7547f8ff4bd57fa600a9df6e1a368a1bc0::pupu {
    struct PUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPU>(arg0, 9, b"PUPU", b"Pupu", b"Pupu To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbd0d208-d63e-4a9f-b3f2-56d500aef448.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

