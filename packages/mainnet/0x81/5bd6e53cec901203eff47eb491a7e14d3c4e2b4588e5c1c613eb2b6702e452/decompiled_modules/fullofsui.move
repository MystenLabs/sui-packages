module 0x815bd6e53cec901203eff47eb491a7e14d3c4e2b4588e5c1c613eb2b6702e452::fullofsui {
    struct FULLOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FULLOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FULLOFSUI>(arg0, 6, b"FULLOFSUI", b"Full of SUI", b"talkin sui, sui posting, just full of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732193464728.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FULLOFSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FULLOFSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

