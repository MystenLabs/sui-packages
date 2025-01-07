module 0x3b7ec9f161f71bd86ee0d2cfe6c7ba6d3228c330fb1aa42468e14a07d2c3655a::APEPE {
    struct APEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<APEPE>, arg1: 0x2::coin::Coin<APEPE>) {
        0x2::coin::burn<APEPE>(arg0, arg1);
    }

    fun init(arg0: APEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEPE>(arg0, 6, b"AIPEPE", b"APEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEPE>>(v1);
        0x2::coin::mint_and_transfer<APEPE>(&mut v2, 1000000000000000, @0x346d21dcaef63a694689357a934acd97e561b579712dc2b6b5a0ee41550dff68, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEPE>>(v2, @0x346d21dcaef63a694689357a934acd97e561b579712dc2b6b5a0ee41550dff68);
    }

    // decompiled from Move bytecode v6
}

