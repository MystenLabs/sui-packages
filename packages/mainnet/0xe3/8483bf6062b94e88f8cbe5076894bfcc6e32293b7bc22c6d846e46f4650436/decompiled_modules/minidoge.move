module 0xe38483bf6062b94e88f8cbe5076894bfcc6e32293b7bc22c6d846e46f4650436::minidoge {
    struct MINIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDOGE>(arg0, 9, b"MINIDOGE", b"Minidoge", b"MINIDOGE meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8J6CexwfJ8CSzn2DgWhzQe1NHd2hK9DKX59FCNNMo2hu.png?size=xl&key=80cfa8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINIDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

