module 0xcd8d31873937c9c7c5d3eba9afa149bbf456ebcfd0aed39215f60b5a7fe58a7a::dfr {
    struct DFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFR>(arg0, 9, b"DFR", b"DRAGONFLY", b"BEAUTIFUL DRAGONFLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d112509-c014-4311-815b-0f89d872fb4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

