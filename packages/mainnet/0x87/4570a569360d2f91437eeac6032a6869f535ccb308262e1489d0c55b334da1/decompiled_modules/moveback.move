module 0x874570a569360d2f91437eeac6032a6869f535ccb308262e1489d0c55b334da1::moveback {
    struct MOVEBACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEBACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEBACK>(arg0, 6, b"MOVEBACK", b"Movepump Back", x"4d616b65204d6f766550756d70204261636b20416761696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073384_8d88f71810.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEBACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEBACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

