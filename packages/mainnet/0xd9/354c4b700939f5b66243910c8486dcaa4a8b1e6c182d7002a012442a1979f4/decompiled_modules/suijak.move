module 0xd9354c4b700939f5b66243910c8486dcaa4a8b1e6c182d7002a012442a1979f4::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAK>(arg0, 4, b"Suijak", b"SJAK", b"t.me/SuijakCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/MNrs1ws/suijak.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJAK>>(v1);
        0x2::coin::mint_and_transfer<SUIJAK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIJAK>>(v2);
    }

    // decompiled from Move bytecode v6
}

