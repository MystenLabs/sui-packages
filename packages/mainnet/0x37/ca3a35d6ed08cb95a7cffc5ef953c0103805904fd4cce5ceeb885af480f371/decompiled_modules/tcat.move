module 0x37ca3a35d6ed08cb95a7cffc5ef953c0103805904fd4cce5ceeb885af480f371::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"TURBO CAT", b"Welcome to Turbo Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961778421.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

