module 0xa6765beb6112a9814b90b738c8ec520a17f015eb7ca7913bf4cc5aec0ca86f17::cee {
    struct CEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEE>(arg0, 9, b"CEE", b"cheese", b"Delicious to buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7f15e5f-0068-48e3-b89c-d882b2da9592.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

