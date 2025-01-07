module 0x9d5634e6d9e75c73e3671f34ed7be2f5067c799fd0764bc07a54601f2961b0ee::suipaw {
    struct SUIPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAW>(arg0, 9, b"SUIPAW", b"SUIPAW", b"Foot Print Of a Bullish DOGE on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/fWjy98I.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPAW>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPAW>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

