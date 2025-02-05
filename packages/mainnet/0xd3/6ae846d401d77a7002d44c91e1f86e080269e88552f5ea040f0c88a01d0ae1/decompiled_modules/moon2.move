module 0xd36ae846d401d77a7002d44c91e1f86e080269e88552f5ea040f0c88a01d0ae1::moon2 {
    struct MOON2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON2>(arg0, 9, b"QUI2", b"QUI2", b"TESTTTTTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://baobariavungtau.com.vn/dataimages/202212/original/images1775623_7m3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON2>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON2>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOON2>>(v2);
    }

    // decompiled from Move bytecode v6
}

