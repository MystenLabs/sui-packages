module 0xef2a7bc32dcd85f6299a70a3b9ebdb946e1e3e4c376bd839087eb969ce72b66f::dca {
    struct DCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCA>(arg0, 6, b"DCA", b"Degen Careless Apes", b"I'll show them all...I can be a great monke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_d705829187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

