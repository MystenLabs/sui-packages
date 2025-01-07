module 0xd3e9a7201926c98abda226a1ff9f4712754487ba0db16e23e3fb4550bc9c241f::brrr {
    struct BRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRRR>(arg0, 6, b"Brrr", b"brrr.money", b"Money printer game, brrrrrrrrrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000125829_76c849c3c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

