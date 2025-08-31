module 0xac1333c5ce8144ea22fb47af877ae013e4e4724b2a850fb8fff419bb80babff9::bbq {
    struct BBQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBQ>(arg0, 6, b"BBQ", b"BBQ", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBQ>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBQ>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBQ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

