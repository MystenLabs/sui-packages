module 0x8e344cfff2af8f99e6932a1629a07d5cb47dc861167cc6757de45db7a73ee87::b_blue {
    struct B_BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLUE>(arg0, 9, b"bBLUE", b"bToken BLUE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

