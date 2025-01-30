module 0x664e5a8936a8044eb05f22710eb2a7cba535b7debc9a415a6f4b2209aa9519c3::uvan92 {
    struct UVAN92 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UVAN92, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UVAN92>(arg0, 9, b"UVAN92", b"UVwewe", b"Loading, up, rocket ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87f656d9-70a1-4683-bd69-fa1d70a4e727.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UVAN92>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UVAN92>>(v1);
    }

    // decompiled from Move bytecode v6
}

