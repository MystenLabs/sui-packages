module 0xd1aeef7b349e83d6727f3263f81bb0148c01cb1312f4f75d0e020defe2a68460::mr {
    struct MR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR>(arg0, 6, b"MR", b"$Mr", b"new meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BCD_32_D60_F0_F5_4182_BDA_2_01_B654_CFB_912_c915301e11.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MR>>(v1);
    }

    // decompiled from Move bytecode v6
}

