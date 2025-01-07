module 0x46055ba67a66bdceba48788b153db502ba64690e1e7b6f16d6c89e90ff939622::suimeng {
    struct SUIMENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMENG>(arg0, 6, b"SUIMENG", b"Meng Chong on SUI", b"Token for the cutest bunny on TikTok! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hzar_Qcn8_400x400_169145eaa5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

