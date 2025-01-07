module 0xdba6effc0fe8dd036f0a74d3e2894ddae03fd2fb1ee66649ec28d15d3794fe5d::sanin {
    struct SANIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIN>(arg0, 6, b"SANIN", b"SANIN THE SUI CHIB", x"53484942204f4e20455448202e2e2e0a53414e494e204f4e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_41bd99c5b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

