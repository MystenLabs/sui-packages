module 0xa085e6f36a26ae6525abc1583f034a9f87a7d5496e96749cf0cb0e0ba8d8d1a8::suicoin {
    struct SUICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOIN>(arg0, 6, b"SUIC", b"SUICIDE", b"suicide.fi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/axQBBkZ.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICOIN>>(v1);
        0x2::coin::mint_and_transfer<SUICOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

