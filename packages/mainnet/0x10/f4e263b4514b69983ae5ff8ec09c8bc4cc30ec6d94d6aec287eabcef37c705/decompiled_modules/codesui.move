module 0x10f4e263b4514b69983ae5ff8ec09c8bc4cc30ec6d94d6aec287eabcef37c705::codesui {
    struct CODESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODESUI>(arg0, 6, b"CODESUI", b"Coded SUI", b"The system obeys the code. It is not rigged, it's $CODED for millions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_0b6f5402a6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

