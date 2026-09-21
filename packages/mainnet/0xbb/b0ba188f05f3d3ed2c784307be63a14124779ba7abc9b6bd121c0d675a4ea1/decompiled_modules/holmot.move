module 0xbbb0ba188f05f3d3ed2c784307be63a14124779ba7abc9b6bd121c0d675a4ea1::holmot {
    struct HOLMOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLMOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLMOT>(arg0, 9, b"Holmot", b"$HOLMOT", b"Called by https://x.com/Mjbdran via@Ourblastbot deploy a token Name: Holmot Ticker: $HOLMOT Image : https://t.co/g01ab6V1ZM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.suipump.org/icons/c5d7956f7f579cee84146fedc27e35a6.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HOLMOT>>(0x2::coin::mint<HOLMOT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLMOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLMOT>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

