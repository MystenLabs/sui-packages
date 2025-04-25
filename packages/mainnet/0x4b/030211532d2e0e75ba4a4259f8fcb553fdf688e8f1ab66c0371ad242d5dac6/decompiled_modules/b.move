module 0x4b030211532d2e0e75ba4a4259f8fcb553fdf688e8f1ab66c0371ad242d5dac6::b {
    struct B has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<B>, arg1: 0x2::coin::Coin<B>) {
        0x2::coin::burn<B>(arg0, arg1);
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 6, b"BGB", b"b", b"lalala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/Users/thangpham/Downloads/tg_image_779987844.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<B>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

