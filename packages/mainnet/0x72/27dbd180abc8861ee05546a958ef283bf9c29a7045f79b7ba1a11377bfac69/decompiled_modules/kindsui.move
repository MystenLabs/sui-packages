module 0x7227dbd180abc8861ee05546a958ef283bf9c29a7045f79b7ba1a11377bfac69::kindsui {
    struct KINDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINDSUI>(arg0, 9, b"KINDSUI", b"Konder on Sui", b"Kinder Suiprise ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/204d9c30e860484838b3cf197d79124cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

