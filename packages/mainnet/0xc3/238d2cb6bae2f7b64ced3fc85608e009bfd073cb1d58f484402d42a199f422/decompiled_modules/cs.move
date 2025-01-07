module 0xc3238d2cb6bae2f7b64ced3fc85608e009bfd073cb1d58f484402d42a199f422::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"CESHI", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

