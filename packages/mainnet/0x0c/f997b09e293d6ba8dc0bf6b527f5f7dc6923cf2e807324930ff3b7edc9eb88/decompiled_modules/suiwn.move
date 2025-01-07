module 0xcf997b09e293d6ba8dc0bf6b527f5f7dc6923cf2e807324930ff3b7edc9eb88::suiwn {
    struct SUIWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWN>(arg0, 6, b"SUIWN", b"Suiwn", b"The best mascot on Sui - Suiwn on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000157545_638651d71c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

