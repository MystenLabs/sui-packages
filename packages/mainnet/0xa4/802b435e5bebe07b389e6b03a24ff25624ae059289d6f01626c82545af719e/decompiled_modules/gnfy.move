module 0xa4802b435e5bebe07b389e6b03a24ff25624ae059289d6f01626c82545af719e::gnfy {
    struct GNFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNFY>(arg0, 9, b"GNFY", b"Grinify", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GNFY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

