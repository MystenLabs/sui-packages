module 0xb140d5873537a1620673c0966e0f6a902ceff357baae0e48fb475ee7edf381d4::vtest {
    struct VTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTEST>(arg0, 9, b"vtest", b"vtest", b"by vulkan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VTEST>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

