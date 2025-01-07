module 0x34f04b86d11fb3fcce0d69414bdb42771ba48b9c0065164fcd1cfee112412303::by315 {
    struct BY315 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY315, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY315>(arg0, 9, b"BY315", b"AIY", b"artificial intelligence towards the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44479c93-52aa-4fd8-9b7a-7413d55d9f59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY315>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY315>>(v1);
    }

    // decompiled from Move bytecode v6
}

