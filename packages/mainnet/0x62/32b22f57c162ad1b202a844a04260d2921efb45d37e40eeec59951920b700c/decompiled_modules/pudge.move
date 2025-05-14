module 0x6232b22f57c162ad1b202a844a04260d2921efb45d37e40eeec59951920b700c::pudge {
    struct PUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGE>(arg0, 6, b"PUDGE", b"PUDGY DOGE", b"Powered by pure thiccness and zero cardio, $PUDGE is waddling slow and steady to the top. Stop chasing tokens; embrace the pudge and wheeze your way to greatness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiasudbddtssm5vcwxtlnr7b3p4sicanturjskoyzbdqqki7mronqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUDGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

