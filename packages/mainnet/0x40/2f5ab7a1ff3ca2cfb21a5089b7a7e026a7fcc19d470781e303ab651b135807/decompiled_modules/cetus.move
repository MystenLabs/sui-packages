module 0x402f5ab7a1ff3ca2cfb21a5089b7a7e026a7fcc19d470781e303ab651b135807::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: 0x2::coin::Coin<CETUS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<CETUS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS>>(0x2::coin::mint<CETUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CETUS>(arg0, 9, b"CETUS", b"CETUS", x"434554555320e280942043657475732050726f746f636f6c20746f6b656e206f6e205375692e204445582c206c69717569646974792c20616e64206d6f726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/cetus.jpeg/public")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CETUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CETUS>>(v0);
    }

    // decompiled from Move bytecode v6
}

