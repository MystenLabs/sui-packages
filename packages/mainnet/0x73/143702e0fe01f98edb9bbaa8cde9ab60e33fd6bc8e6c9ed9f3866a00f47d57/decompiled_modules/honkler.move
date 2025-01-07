module 0x73143702e0fe01f98edb9bbaa8cde9ab60e33fd6bc8e6c9ed9f3866a00f47d57::honkler {
    struct HONKLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONKLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONKLER>(arg0, 6, b"HONKLER", b"Honkler", x"486f6e6b6c657220697320612066756e206d656d6520636f696e207468617420726570726573656e747320696e20612073696c6c79207761792074686520636c6f776e20776f726c642074686174207765206c69766520696e20746f6461790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hunkler_a292aa7458.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONKLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONKLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

