module 0x46e5b548d49a63640c3e0055f4ffcfcef20a245756bd02f7c60c77eb1b72e456::abcdd {
    struct ABCDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCDD>(arg0, 6, b"ABCDD", b"ABCD", b"ASASASASASA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778249080506.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABCDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

