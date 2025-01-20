module 0x9def2e389e2fafa26041c14f6cf26b4127996bd77d70b9f54caa74f48bf73f82::joos {
    struct JOOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOS>(arg0, 6, b"JOOS", b"Da Joos", b"We all nose.  Oh vey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737335995878.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

