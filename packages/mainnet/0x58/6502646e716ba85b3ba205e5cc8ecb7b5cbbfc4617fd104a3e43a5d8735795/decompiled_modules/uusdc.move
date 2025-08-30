module 0x586502646e716ba85b3ba205e5cc8ecb7b5cbbfc4617fd104a3e43a5d8735795::uusdc {
    struct UUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUSDC>(arg0, 6, b"uUSDC", b"Ultra USDC", b"This is a receipt token received only upon depositing to Vaults", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn4.iconfinder.com/data/icons/money-currency-1/512/Money_Currency_Coin_Payment_USD_Dollar-512.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

