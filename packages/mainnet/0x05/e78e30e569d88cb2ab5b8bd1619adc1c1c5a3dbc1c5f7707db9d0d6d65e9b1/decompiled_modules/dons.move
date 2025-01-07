module 0x5e78e30e569d88cb2ab5b8bd1619adc1c1c5a3dbc1c5f7707db9d0d6d65e9b1::dons {
    struct DONS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DONS>, arg1: 0x2::coin::Coin<DONS>) {
        0x2::coin::burn<DONS>(arg0, arg1);
    }

    fun init(arg0: DONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONS>(arg0, 9, b"dons", b"Dons", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/25219.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONS>>(v1);
        0x2::coin::mint_and_transfer<DONS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DONS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DONS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

