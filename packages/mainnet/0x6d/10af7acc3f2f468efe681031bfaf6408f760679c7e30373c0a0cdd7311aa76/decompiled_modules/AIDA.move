module 0x6d10af7acc3f2f468efe681031bfaf6408f760679c7e30373c0a0cdd7311aa76::AIDA {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDA>(arg0, 9, b"AIDA", b"AIDA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIDA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIDA>>(0x2::coin::mint<AIDA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

