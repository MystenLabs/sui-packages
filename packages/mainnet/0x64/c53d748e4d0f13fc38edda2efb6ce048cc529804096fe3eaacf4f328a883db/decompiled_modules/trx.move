module 0x64c53d748e4d0f13fc38edda2efb6ce048cc529804096fe3eaacf4f328a883db::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 6, b"USD1", b"USD1", b"USD1 is a fixed-supply token on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvgget4b2mhxvo6ub3q67zh7ttn5rbczovnxeutf24ps4d7yofv4")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRX>>(0x2::coin::mint<TRX>(&mut v2, 3000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRX>>(v2);
    }

    // decompiled from Move bytecode v6
}

