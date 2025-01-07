module 0xdf1083e6f6bf805711b9231bfc0f9ec1e8be5a80056299764e43a78796dc4267::ygo {
    struct YGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGO>(arg0, 6, b"YGO", b"YELLOW GROUPER  1", x"444f4e542042555920204a757374206a6f696e206f757220636f6d6d756e697479200a5745204c4f554e4348204146544552203530204d454d424552205447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_23_08_12_c2d53b8c_9d79f8f24f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

