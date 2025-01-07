module 0x484d84de7fd89a7af820b947d43d07abf22d94c55c2f10a50eaab10f77ff1737::pbroke {
    struct PBROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBROKE>(arg0, 6, b"PBROKE", b"Broke Piggy", b"don't buy lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d8e894de84e9fc6f41fabb4e130544a6_72d4d0e2f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

