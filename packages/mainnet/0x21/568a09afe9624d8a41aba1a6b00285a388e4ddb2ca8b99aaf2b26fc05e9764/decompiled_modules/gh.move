module 0x21568a09afe9624d8a41aba1a6b00285a388e4ddb2ca8b99aaf2b26fc05e9764::gh {
    struct GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH>(arg0, 9, b"GH", b"Gohan", b"GOHAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0a211df-351c-4fde-b634-1e506ce57fa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH>>(v1);
    }

    // decompiled from Move bytecode v6
}

