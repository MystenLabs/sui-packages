module 0x63ced066a7bf6d0749ad1404f758b26acb125df36ce0b61ee611794eb9a117db::bulls {
    struct BULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLS>(arg0, 8, b"BULLS", b"Sui bullrun", b"Bullrun coming for sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLS>(&mut v2, 6677788855500000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

