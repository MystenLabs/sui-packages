module 0x63b0ef612a2b9920684e7d4b38bdd4a87dd3d2f4fd31b9ffe4ed99d61c0ef504::b_zxc {
    struct B_ZXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZXC>(arg0, 9, b"bZXC", b"bToken ZXC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

