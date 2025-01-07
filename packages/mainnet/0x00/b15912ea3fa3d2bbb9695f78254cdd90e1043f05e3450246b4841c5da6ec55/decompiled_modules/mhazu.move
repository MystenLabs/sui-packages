module 0xb15912ea3fa3d2bbb9695f78254cdd90e1043f05e3450246b4841c5da6ec55::mhazu {
    struct MHAZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHAZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHAZU>(arg0, 6, b"Mhazu", b"Mihazu", b"Miharus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_2j9g_FXQA_44hu_541d1a3f41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHAZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHAZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

