module 0x7a05d86898d2a0fb936590862df7cb1156dfce7912a8e95922be7f2b910d0bb::slc {
    struct SLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLC>(arg0, 6, b"SLC", b"Sui Lovers Club", b"Just a token fur Sui lovers, holders, traders. Make Sui to the top in 2025!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Aida_90829c839c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

