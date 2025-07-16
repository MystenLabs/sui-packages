module 0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold {
    struct PAWTATO_COIN_GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_GOLD>(arg0, 9, b"GOLD", b"Pawtato Gold", b"Precious metal found in Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/gold.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_GOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_GOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_gold(arg0: 0x2::coin::Coin<PAWTATO_COIN_GOLD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_GOLD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

