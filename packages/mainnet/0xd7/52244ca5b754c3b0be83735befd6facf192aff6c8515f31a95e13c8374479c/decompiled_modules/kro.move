module 0xd752244ca5b754c3b0be83735befd6facf192aff6c8515f31a95e13c8374479c::kro {
    struct KRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRO>(arg0, 6, b"KRO", b"Kuro", b"Kuroro Universe Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004424_6b2b3760f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

