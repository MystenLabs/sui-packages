module 0x6d340d319955417a370dd657a8f70f42526faf5aa5a5a027b4b4e62866ad52e5::snowball {
    struct SNOWBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWBALL>(arg0, 6, b"SNOWBALL", b"Snowball on Sui", x"7468652069636f6e69632073796d626f6c206f662077696e74657220616e6420706c61792c2024534e4f5742414c4c206f6e205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fq_DH_8uaxx_BT_5_SEZ_1v_EMTA_Yi_DEF_Tyb_D3xt_KA_Zze_F_Vbzty_1_2da6164cfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

