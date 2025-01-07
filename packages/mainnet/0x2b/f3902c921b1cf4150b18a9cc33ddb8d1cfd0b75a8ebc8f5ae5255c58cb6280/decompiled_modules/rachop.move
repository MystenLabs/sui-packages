module 0x2bf3902c921b1cf4150b18a9cc33ddb8d1cfd0b75a8ebc8f5ae5255c58cb6280::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 4, b"RACHOP", b"RacHop", b"Just a racoon from the hop.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RACHOP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

