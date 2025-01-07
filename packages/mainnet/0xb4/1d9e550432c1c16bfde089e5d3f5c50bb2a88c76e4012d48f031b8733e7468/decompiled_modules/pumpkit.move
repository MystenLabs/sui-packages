module 0xb41d9e550432c1c16bfde089e5d3f5c50bb2a88c76e4012d48f031b8733e7468::pumpkit {
    struct PUMPKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIT>(arg0, 6, b"PUMPKIT", b"Pumpkitty", b"I'm the purrfect Halloween treat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pumpkincatlogo_6b7a51a0dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

