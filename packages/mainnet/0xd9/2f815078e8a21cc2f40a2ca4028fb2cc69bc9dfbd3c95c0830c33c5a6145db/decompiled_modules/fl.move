module 0xd92f815078e8a21cc2f40a2ca4028fb2cc69bc9dfbd3c95c0830c33c5a6145db::fl {
    struct FL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL>(arg0, 9, b"FL", b"Florida", b"Rescue team ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4efacec5-048d-45c9-8697-090aa76b0e78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL>>(v1);
    }

    // decompiled from Move bytecode v6
}

