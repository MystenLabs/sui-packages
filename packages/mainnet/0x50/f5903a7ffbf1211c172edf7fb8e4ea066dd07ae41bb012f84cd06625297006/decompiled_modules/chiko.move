module 0x50f5903a7ffbf1211c172edf7fb8e4ea066dd07ae41bb012f84cd06625297006::chiko {
    struct CHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIKO>(arg0, 6, b"CHIKO", b"CHICK WIF BALLS", x"4e6f7720686573206f7574206865726520687573746c696e672032342f372c20666c697070696e67206d656d65636f696e732c20616e6420676976696e67204269672045676720746865206d6964646c6520666561746865722e205468657920686174652068696d20626563617573652068657320676f74207468652062616c6c7320746f206669676874206261636b2e0a0a4368696b6f7320676f742062616c6c732e20426967206f6e65732e20416e6420696620796f757265206e6f74206f6e20626f6172642c20776861742061726520796f75206576656e20646f696e67207769746820796f7572206c6966653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppx_7bff76206f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

