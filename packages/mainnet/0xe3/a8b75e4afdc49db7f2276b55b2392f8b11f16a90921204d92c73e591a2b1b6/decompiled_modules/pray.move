module 0xe3a8b75e4afdc49db7f2276b55b2392f8b11f16a90921204d92c73e591a2b1b6::pray {
    struct PRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRAY>(arg0, 6, b"PRAY", b"Pray", b"Have faith.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PRAY_d6b30e0867.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

