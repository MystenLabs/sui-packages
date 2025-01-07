module 0xd9337b98d9fbf9e8b697677f24bf3f874fe0cfb7408df8e76244e56864f3b944::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 6, b"Mars", b"Mars Musk", x"486f7020696e2c207765726520676f696e6720746f204d6172732120202d2d456c6f6e204d75736b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mars_T_Knx_La_rz3_D8sfdu3h_F_cbe3604a41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

