module 0x7ab0180d1a1db20b5c6eb87248c8b70b0e9fcc8462f050d4d5fcacacfcdbc95e::chinshurin {
    struct CHINSHURIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINSHURIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINSHURIN>(arg0, 6, b"CHIN", b"CHINSHURIN", b"A pearl that shakes the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co.com/5jBN2h1/giant-red-pearlscale-goldfish-grade-aa.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHINSHURIN>(&mut v2, 7777777777777000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINSHURIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINSHURIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

