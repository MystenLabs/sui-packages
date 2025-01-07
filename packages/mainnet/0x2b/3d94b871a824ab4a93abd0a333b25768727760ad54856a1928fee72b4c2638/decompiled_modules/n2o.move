module 0x2b3d94b871a824ab4a93abd0a333b25768727760ad54856a1928fee72b4c2638::n2o {
    struct N2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: N2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N2O>(arg0, 6, b"N2O", b"Nitrous Oxide", b"Turbo? Get a load of Nitro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730974904686.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N2O>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N2O>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

