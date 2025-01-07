module 0x62718a8ee34feeacd3535c3668032cb3db373207f2d70c8e126e6db343566d9f::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Whale", b"Why chase minnows when you can ride with a Whale? This memecoin, powered by the secure and scalable Sui blockchain, offers you a chance to harness the currents of innovation and join a community thats taking the crypto world by storm. Catch the wave and see where Whale takes you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B239_EE_49_4448_41_DF_8_D78_610_A2_CD_1_C5_C8_83c16b6a99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

