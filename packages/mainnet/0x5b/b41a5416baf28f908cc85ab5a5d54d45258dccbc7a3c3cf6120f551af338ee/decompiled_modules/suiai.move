module 0x5bb41a5416baf28f908cc85ab5a5d54d45258dccbc7a3c3cf6120f551af338ee::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 6, b"SUIAI", b"suiai", b"SUI AI ON MOVE PUMP (At Sui AI, everything will happen as planned)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_ca79278686.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

