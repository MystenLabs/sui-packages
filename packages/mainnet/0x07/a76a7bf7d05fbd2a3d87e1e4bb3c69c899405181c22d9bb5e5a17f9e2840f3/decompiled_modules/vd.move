module 0x7a76a7bf7d05fbd2a3d87e1e4bb3c69c899405181c22d9bb5e5a17f9e2840f3::vd {
    struct VD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VD>(arg0, 3, b"VD", x"c3814141", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/06dd4670-d89b-11ef-8165-f761f2caed44")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VD>>(v1);
        0x2::coin::mint_and_transfer<VD>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

