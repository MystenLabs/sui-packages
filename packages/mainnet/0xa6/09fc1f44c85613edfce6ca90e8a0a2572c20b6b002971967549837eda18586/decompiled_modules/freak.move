module 0xa609fc1f44c85613edfce6ca90e8a0a2572c20b6b002971967549837eda18586::freak {
    struct FREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAK>(arg0, 6, b"FREAK", b"The Freak", b"Be weird. Be wild. Be freak.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiecowmkziuibf7ze2ug4vttonfdh7xowvgwn3livdloe4h7licvay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

