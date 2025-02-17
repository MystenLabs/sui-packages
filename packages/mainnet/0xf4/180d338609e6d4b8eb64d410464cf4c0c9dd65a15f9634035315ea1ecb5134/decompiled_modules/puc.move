module 0xf4180d338609e6d4b8eb64d410464cf4c0c9dd65a15f9634035315ea1ecb5134::puc {
    struct PUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUC>(arg0, 6, b"PUC", x"70d1966e39352d7570e280a4636f6d", b"Official pin up coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resourcesen.sbceurasia.com/sbccisen/sites/2/2023/09/pin-up-casino.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUC>(&mut v2, 9800000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUC>>(v2, @0xf380bdd21b30032e75852ef548acf09dd189b45cbf5cda65793df2e1d896a90b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

