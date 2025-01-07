module 0x3e54dc84043136239945c2eb0dc58c4697dc95bd4c35730358b54a24a6fc51c6::abi {
    struct ABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABI>(arg0, 9, b"ABI", b"Abiii", b"Lover of nature .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76db556c-38ad-4767-b2a5-eeb26b83701b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

