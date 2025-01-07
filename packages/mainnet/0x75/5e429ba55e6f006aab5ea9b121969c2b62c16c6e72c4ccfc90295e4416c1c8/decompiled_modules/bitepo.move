module 0x755e429ba55e6f006aab5ea9b121969c2b62c16c6e72c4ccfc90295e4416c1c8::bitepo {
    struct BITEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITEPO>(arg0, 6, b"BITEPO", b"Bitepo", b"Bitepo is launched on MovePump! The most amazing Hippo who can open its mouth wide enough to bite most of anything in this world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_17724c1a1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

