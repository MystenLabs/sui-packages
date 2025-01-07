module 0x345704117954f5408814114001c3ea789abdcec5d74c47b2cd25e7047a3e4284::NUTZ {
    struct NUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTZ>(arg0, 2, b"NUTZ", b"NUTZ", b"Can you suck my $NUTZ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co.com/tqLsJsw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTZ>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUTZ>(&mut v2, 100000, @0xf078e8ed8762cc61ff9f9447a6c6931554c2a223ba5d8fa0b47b3fd3c14e4d64, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTZ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

