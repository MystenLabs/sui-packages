module 0x7f3eb24e7fe252d7133d199bff308ef2c25fd5633466ace21032f03fe5fd47cd::sckcat {
    struct SCKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCKCAT>(arg0, 6, b"SCKCAT", b"SICKCAT", b"Just a sick cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731105329332.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCKCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCKCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

