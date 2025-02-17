module 0x1d34888bc994cad851167939348a4110d2792bfc656d8260f29ed0540cb995a9::busd {
    struct BUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSD>(arg0, 9, b"BUSD", b"BUSD", b"Binance USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/40n71WzISQM9pCxRho77tl8wue5ndS1qEp1156sdNY8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUSD>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSD>>(v2, @0x3571e2eb860aafcaa53782791b8c2e1bc637ec96b905fd55cf736d57517c7ce4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

