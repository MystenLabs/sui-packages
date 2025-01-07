module 0x3084c0d51d7df73dcb47c730bd13a9de6afb036b0495ff94ab7dc41dc27b6898::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 9, b"MILK", b"MILK", b"lechita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2ubuHGFS4VJVxSEpvV3kDwz6JiuXdaAoGMwrwYC87tp8.png?size=lg&key=6007a6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILK>(&mut v2, 7362487628000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

