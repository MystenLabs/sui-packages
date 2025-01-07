module 0xad32514ae0394bf10cafb024d922e8486ae1739e9f5d7454d6a216655fcba003::minifud {
    struct MINIFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIFUD>(arg0, 9, b"MINIFUD", b"MINIFUD", b"MINIFUD", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINIFUD>(&mut v2, 10900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIFUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

