module 0x8b067492fab26ac2c344f37c71787d839befa9d84f8fa03b9d736ade1d1f2b0c::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 7, b"FOMO", b"Fear of missing out", b"Opposite of FUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.qwant.com/?client=brz-brave&t=images&q=fomo&o=0%3A1EA8C99E421D33D226488E41869B492F7F2C146F")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<FOMO>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

