module 0x78078f9970e252ab4c4ba4ae9873d3155d1f6d544992a0f21abd5a72109a4cb7::moony {
    struct MOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONY>(arg0, 6, b"MOONY", b"Moony On Sui", b"$MOONY The fastest turtle on the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000071171_e97db767b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

