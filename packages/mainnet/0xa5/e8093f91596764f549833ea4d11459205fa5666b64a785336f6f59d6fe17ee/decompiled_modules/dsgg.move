module 0xa5e8093f91596764f549833ea4d11459205fa5666b64a785336f6f59d6fe17ee::dsgg {
    struct DSGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSGG>(arg0, 9, b"DSGG", b"GSFDS", b"GSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2fe35b2-eea5-4027-aeca-6df191f54787.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

