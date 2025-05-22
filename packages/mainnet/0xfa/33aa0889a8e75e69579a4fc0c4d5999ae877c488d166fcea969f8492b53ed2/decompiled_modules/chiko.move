module 0xfa33aa0889a8e75e69579a4fc0c4d5999ae877c488d166fcea969f8492b53ed2::chiko {
    struct CHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIKO>(arg0, 6, b"CHIKO", b"CHICK WIF BALLS", x"4865206973206f7574206865726520687573746c696e672032342f372c20666c697070696e67206d656d65636f696e7320616e6420676976696e67204269672045676720746865206d6964646c6520666561746865722e205468657920686174652068696d206265636175736520686520676f74207468652062616c6c7320746f206669676874206261636b210a0a4368696b6f20676f742062616c6c732c20626967206f6e65732e20416e6420696620796f7520617265206e6f74206f6e20626f6172642c20776861742061726520796f75206576656e20646f696e67207769746820796f7572206c6966653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdo3anpuh2velobkdnt54zmn4myv65idfbxhiomvvx2rz47adfhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

