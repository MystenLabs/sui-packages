module 0x8214bef1cc233cbdeb3710541e1c99505c14cb513e751c5bce9172e7b924dfca::sui_kitty {
    struct SUI_KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_KITTY>(arg0, 9, b"SUI KITTY", x"f09f90b1537569204b69747479", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_KITTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_KITTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

