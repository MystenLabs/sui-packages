module 0xc96cffed9f7800846e358f84ff347d2a9901e4f61688c14f1135336c040ceab2::suilords {
    struct SUILORDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILORDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILORDS>(arg0, 6, b"SUILORDS", b"SuiLords", b"The Real Lords of Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5559_e873aea876.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILORDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILORDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

