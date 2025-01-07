module 0x9d9b8688fd8a52c30a07f9378051f03121c056ecb94f77aa45606c458053a52::yasu {
    struct YASU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YASU>, arg1: 0x2::coin::Coin<YASU>) {
        0x2::coin::burn<YASU>(arg0, arg1);
    }

    fun init(arg0: YASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YASU>(arg0, 9, b"YASU", b"YASU", b"Yasu Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/75BwcZph6NoXf89pVwfujax5duchEMVVh16F4Gispump.png?size=xl&key=402fe1")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YASU>>(v1);
        0x2::coin::mint_and_transfer<YASU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YASU>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YASU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YASU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

