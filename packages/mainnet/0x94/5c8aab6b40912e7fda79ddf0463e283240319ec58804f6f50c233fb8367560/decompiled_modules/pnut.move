module 0x945c8aab6b40912e7fda79ddf0463e283240319ec58804f6f50c233fb8367560::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 9, b"PNUT", b"Peanut the Squirrel", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://image.coinpedia.org/wp-content/uploads/2024/11/14190742/PNUT-Coin-Price-Prediction-Largest-PNUT-Holder-Makes-56M%E2%80%94Will-the-Trend-Persist.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PNUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

