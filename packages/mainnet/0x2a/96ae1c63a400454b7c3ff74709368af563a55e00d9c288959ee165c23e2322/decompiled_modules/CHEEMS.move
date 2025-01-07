module 0x2a96ae1c63a400454b7c3ff74709368af563a55e00d9c288959ee165c23e2322::CHEEMS {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHEEMS>, arg1: 0x2::coin::Coin<CHEEMS>) {
        0x2::coin::burn<CHEEMS>(arg0, arg1);
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 2, b"Cheems", b"Sui Cheems", b"Cheems on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/10269.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEEMS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHEEMS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

