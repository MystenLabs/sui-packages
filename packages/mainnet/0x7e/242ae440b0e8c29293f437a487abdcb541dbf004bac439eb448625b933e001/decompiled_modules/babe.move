module 0x7e242ae440b0e8c29293f437a487abdcb541dbf004bac439eb448625b933e001::babe {
    struct BABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABE>(arg0, 6, b"BABE", b"BABE", b"BABE fuel for souls seeking max power on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/F1dSzbFvC9uMbFeDQpsJvfosbkEdttYZ2riqhEivaQYZ.png?size=lg&key=ad42db")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

