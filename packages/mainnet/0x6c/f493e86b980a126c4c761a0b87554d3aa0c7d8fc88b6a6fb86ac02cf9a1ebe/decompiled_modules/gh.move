module 0x6cf493e86b980a126c4c761a0b87554d3aa0c7d8fc88b6a6fb86ac02cf9a1ebe::gh {
    struct GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH>(arg0, 9, b"GH", b"W", b"Ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b43f9604-4de5-4d1e-a23b-3a74a42698a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH>>(v1);
    }

    // decompiled from Move bytecode v6
}

