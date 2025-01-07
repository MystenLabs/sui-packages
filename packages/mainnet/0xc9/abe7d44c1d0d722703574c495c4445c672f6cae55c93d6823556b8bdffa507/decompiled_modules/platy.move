module 0xc9abe7d44c1d0d722703574c495c4445c672f6cae55c93d6823556b8bdffa507::platy {
    struct PLATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATY>(arg0, 6, b"PLATY", b"Bored Platypus Social Club", b"The native utility token of the Bored Platypus Social Club (BPSC), designed to fuel the growth of our community-driven Metaverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bpsc_token_icon_84f2ba7654.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

