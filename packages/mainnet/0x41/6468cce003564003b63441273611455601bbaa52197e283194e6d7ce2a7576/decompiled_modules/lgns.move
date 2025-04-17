module 0x416468cce003564003b63441273611455601bbaa52197e283194e6d7ce2a7576::lgns {
    struct LGNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGNS>(arg0, 6, b"LGNS", b"Longinus", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.expertacademy.be/Cached/2955/piece/880x2000/time-management-tips.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGNS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LGNS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGNS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

