module 0x6e2a7c2f0aebfd06ff2082c9405644ccb3eb9b0a65469a304dfe700dfdb00ba9::percy {
    struct PERCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERCY>(arg0, 6, b"PERCY", b"PERCY VERENCE", b"Percy Verence , Elon's next Caharacter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_04_21_22_29_aca234581e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

