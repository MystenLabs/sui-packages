module 0x8e08af2969e0153ab123b353df75465c130e313ae76d8c4eb233055f070260c1::lobstar {
    struct LOBSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBSTAR>(arg0, 6, b"LOBSTAR", b"Lobstar the Lobster on SUI", b"$LOBSTAR is the one and only blue lobster with muscular claws on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dex_59ff12ea4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBSTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBSTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

