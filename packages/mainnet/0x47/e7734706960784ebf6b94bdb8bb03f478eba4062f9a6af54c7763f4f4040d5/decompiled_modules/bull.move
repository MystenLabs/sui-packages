module 0x47e7734706960784ebf6b94bdb8bb03f478eba4062f9a6af54c7763f4f4040d5::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"bull", b"just a dog in a bull market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GZXM8VD6zcPVAeimvNrfz6tajZuohTeghDiu1DkDpump.png?size=xl&key=e8f78e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

