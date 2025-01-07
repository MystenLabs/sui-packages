module 0x180dd3db6ec15405ae4edd32cd0617d049f55e4287a862a4ab00e8f68ccbdd1e::russell {
    struct RUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSELL>(arg0, 9, b"RUSSELL", b"Russell", b"Brian Armstrong's Dog Russell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x0c5142bc58f9a61ab8c3d2085dd2f4e550c5ce0b.png?size=xl&key=d6734d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUSSELL>(&mut v2, 6000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSELL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

