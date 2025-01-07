module 0x6b93ae906616b1f80898e878105471010077e4ea3828bfb52632f704fa29c3f9::q123411111 {
    struct Q123411111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q123411111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q123411111>(arg0, 9, b"Q123411111", b"AAA", b"H-andsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dce0f9e2-46f8-4ad0-af5a-d3053a50e716.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q123411111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q123411111>>(v1);
    }

    // decompiled from Move bytecode v6
}

