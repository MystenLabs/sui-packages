module 0x423c824373c2c3437e1fc923e737ff88802a97d1322bdfec601211133c74a89d::b_dmc {
    struct B_DMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DMC>(arg0, 9, b"bDMC", b"bToken DMC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

