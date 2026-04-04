module 0x624a7407faa78807b7e8d7488f54eb0c27c832a980f23ff165da35d4e5061854::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIU>(arg0, 6, b"MIU", b"Miu", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIU>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIU>>(v2);
    }

    // decompiled from Move bytecode v6
}

