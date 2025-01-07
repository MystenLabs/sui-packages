module 0xad73f149fee3c238a1737f5703b04087986f5a7d7da1a95d9e43efa357bb5c96::a8 {
    struct A8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A8>(arg0, 9, b"A8", b"Androi 8", b"ANDROI 8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29ce4230-5bd3-4c7d-9930-2e557f053cb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A8>>(v1);
    }

    // decompiled from Move bytecode v6
}

