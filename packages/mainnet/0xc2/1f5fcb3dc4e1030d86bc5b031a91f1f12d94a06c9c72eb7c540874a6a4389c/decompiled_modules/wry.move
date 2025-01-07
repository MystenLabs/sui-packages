module 0xc21f5fcb3dc4e1030d86bc5b031a91f1f12d94a06c9c72eb7c540874a6a4389c::wry {
    struct WRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRY>(arg0, 9, b"WRY", b"We're youg", b"We are young", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc124e82-1dc9-47d1-90c3-60c7596eded9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

