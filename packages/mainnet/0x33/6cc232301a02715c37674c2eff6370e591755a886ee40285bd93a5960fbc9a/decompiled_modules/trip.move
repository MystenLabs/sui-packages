module 0x336cc232301a02715c37674c2eff6370e591755a886ee40285bd93a5960fbc9a::trip {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"Trump is Dead", b"Just facts...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyg7jw7mvll22zcuqdqcosjyubdxoe7hpologuowpe2ggdonja6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

