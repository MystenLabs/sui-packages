module 0xefea711c3355ebecb0854ac81a8b21cbb711096f089a877cb9dabaaa88ce63d0::bal {
    struct BAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAL>(arg0, 9, b"BAL", b"BALENCIAGA", b"BALENCIAGA Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

