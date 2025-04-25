module 0x34d63d6e278d1d1c8009dfc7969c8048ee1a9d12848dc605f44d6258d0d62b87::plippo {
    struct PLIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLIPPO>(arg0, 6, b"PLIPPO", b"Plippo", x"74696e79206d656e6163652c2062696720686561727420646567656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plippo_logo_8f9b8ccb9f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

