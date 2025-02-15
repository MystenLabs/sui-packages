module 0x5b9b5797b1c7e48b6c8602717476dce5bae03ec392de29d7be535a5223e35e17::gz {
    struct GZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZ>(arg0, 9, b"GZ", b"Genz", b"J4fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc257065-6fcc-490b-8c41-f488c4ebf385.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

