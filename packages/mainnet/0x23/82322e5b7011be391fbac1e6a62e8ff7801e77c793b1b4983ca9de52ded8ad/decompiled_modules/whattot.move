module 0x2382322e5b7011be391fbac1e6a62e8ff7801e77c793b1b4983ca9de52ded8ad::whattot {
    struct WHATTOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATTOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATTOT>(arg0, 9, b"whattot", b"whatevertoken", b"whatever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHATTOT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHATTOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHATTOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

