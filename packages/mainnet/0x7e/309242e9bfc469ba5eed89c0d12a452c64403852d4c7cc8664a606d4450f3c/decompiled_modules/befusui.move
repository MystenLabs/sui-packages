module 0x7e309242e9bfc469ba5eed89c0d12a452c64403852d4c7cc8664a606d4450f3c::befusui {
    struct BEFUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEFUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEFUSUI>(arg0, 6, b"BEFUSUI", b"BEFU", x"5468652066756e6e6965737420616e64206d6f7374206d656d652d776f727468792063727970746f2065766572210a54686520646f67677920262066726f6720636f696e7320686164207468656972206d6f6d656e742c206275740a6e6f77206974732042454655207475726e20746f207368696e6520616e64206265636f6d65207468650a756c74696d617465206d656d65206b696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5350_c1809fcc18.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEFUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEFUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

