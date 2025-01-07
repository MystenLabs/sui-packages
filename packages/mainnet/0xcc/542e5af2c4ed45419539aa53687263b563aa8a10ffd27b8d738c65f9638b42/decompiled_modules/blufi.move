module 0xcc542e5af2c4ed45419539aa53687263b563aa8a10ffd27b8d738c65f9638b42::blufi {
    struct BLUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUFI>(arg0, 6, b"BLUFI", b"Blufi on SUI", b"The coolest blue on the block. sblufi.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_132513_aa1f345e16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

