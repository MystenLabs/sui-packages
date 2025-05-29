module 0x84c0c5e5693600cb3a0276228077e26749f4760e95ca833987b6476991c4e1f7::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"Suishi", b"See you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000080977_03adfc9a4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

