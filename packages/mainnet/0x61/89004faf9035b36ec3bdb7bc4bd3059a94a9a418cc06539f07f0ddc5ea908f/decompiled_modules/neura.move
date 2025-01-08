module 0x6189004faf9035b36ec3bdb7bc4bd3059a94a9a418cc06539f07f0ddc5ea908f::neura {
    struct NEURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURA>(arg0, 6, b"NEURA", b"Neura Android", b"Neura is a special approach to the possession of art, the last hope of mankind. Create works using a unique android, upgrade your skills and discover new creative possibilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736362363013.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

