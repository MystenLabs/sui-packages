module 0x5a0d1a1da817ff40c7b179226c250c50f0b78963e23184e0057e80e97d154e22::BALD {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALD>(arg0, 6, b"BALD", b"Bald Dog", b"baldieee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmeDcdwYm9wbpfmX7aGUuaq9YxfQLKeftr8zxjMeHrUyCB")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

