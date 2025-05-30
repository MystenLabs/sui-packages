module 0xb205155188b95304ec56cfebac9def1b8e67520c7a3618e9e6f8f2f3a5bf0329::b_moonboi69 {
    struct B_MOONBOI69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MOONBOI69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MOONBOI69>(arg0, 9, b"bMoonboi69", b"bToken Moonboi69", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MOONBOI69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MOONBOI69>>(v1);
    }

    // decompiled from Move bytecode v6
}

