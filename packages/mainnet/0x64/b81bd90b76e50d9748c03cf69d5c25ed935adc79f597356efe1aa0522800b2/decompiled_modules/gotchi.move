module 0x64b81bd90b76e50d9748c03cf69d5c25ed935adc79f597356efe1aa0522800b2::gotchi {
    struct GOTCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTCHI>(arg0, 8, b"GOTCHI", b"Tamagotchi", b"funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/J3Tzem78WsdZb3y48miXzjSDGLfitv68EK2Xk3vZmn4H.png?size=lg&key=f776a4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOTCHI>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTCHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

