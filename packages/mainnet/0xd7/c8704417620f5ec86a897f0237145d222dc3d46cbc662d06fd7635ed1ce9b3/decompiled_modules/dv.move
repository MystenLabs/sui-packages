module 0xd7c8704417620f5ec86a897f0237145d222dc3d46cbc662d06fd7635ed1ce9b3::dv {
    struct DV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DV>(arg0, 9, b"DV", b"Dave", b"Just a memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d1649d8-7cd1-49e3-bfb5-f137b027d9af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DV>>(v1);
    }

    // decompiled from Move bytecode v6
}

