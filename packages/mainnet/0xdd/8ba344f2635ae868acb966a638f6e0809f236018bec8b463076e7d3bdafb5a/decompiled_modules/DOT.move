module 0xdd8ba344f2635ae868acb966a638f6e0809f236018bec8b463076e7d3bdafb5a::DOT {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 4, b"DOT", b"DOT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/B2VWhLhs/DOT.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOT>(&mut v2, 200000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

