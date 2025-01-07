module 0x58f2b9aa3cc57dfa4bfaa49a43149554450f76537f8f6c433f8abd59d6cb0b41::tribe {
    struct TRIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIBE>(arg0, 6, b"TRIBE", b"SUI TRIBE", b"Tired of rugs? We are building a tribe of SUI traders to make SUI network great. Come join our TG and we make SUI skyrocket! The bigger the tribe, the strong we are!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0001_410cccfd37.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

