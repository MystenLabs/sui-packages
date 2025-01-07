module 0xabae5a7001781d393b3b90c96f504dcdf9a0fbcd1b12187e26fdf5b0b6db72d7::suiant {
    struct SUIANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANT>(arg0, 6, b"SUIANT", b"SUI ANT", b"Red ant entered the world of sui, this red ant will bring you to your dreams...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240914091056_7aaa1ca2e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

