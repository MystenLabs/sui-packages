module 0x4f8c955c18446e3cd59df70f80b51a4689e39127151433d567c23c5a23685a57::Weedle2 {
    struct WEEDLE2 has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<WEEDLE2>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WEEDLE2>>(arg0, arg1);
    }

    fun init(arg0: WEEDLE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEDLE2>(arg0, 9, b"WEEDLE", b"WEELDE2", b"DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.pokemon.com/assets/cms2/img/pokedex/full/013.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<WEEDLE2>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEDLE2>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEDLE2>>(v1);
    }

    // decompiled from Move bytecode v6
}

