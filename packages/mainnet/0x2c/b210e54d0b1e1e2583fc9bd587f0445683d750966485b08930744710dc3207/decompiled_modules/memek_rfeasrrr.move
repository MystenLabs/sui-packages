module 0x2cb210e54d0b1e1e2583fc9bd587f0445683d750966485b08930744710dc3207::memek_rfeasrrr {
    struct MEMEK_RFEASRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRRR>(arg0, 6, b"MEMEKRFEASRRR", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRRR>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRRR>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRRR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

