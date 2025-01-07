module 0xebb0429f4af5c5c58c9e7f9dd0c23ed304c1c5f9ee60aa7d3d13b22374806978::ruud {
    struct RUUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUUD>(arg0, 9, b"RUUD", b"Ruud", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUUD>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

