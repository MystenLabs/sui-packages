module 0xcfcef1360d27885ee1ea6375d8e863abdedfb23791d270e2b9611dd96e6eb3ff::suinardo {
    struct SUINARDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINARDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINARDO>(arg0, 6, b"SUINARDO", b"SUinardo Si SAPRIO", x"546865204d616e20546865204d79746820546865204c6567656e64200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8739471d_f4b2_4673_800a_624bcb8fc477_664c4c7810.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINARDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINARDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

