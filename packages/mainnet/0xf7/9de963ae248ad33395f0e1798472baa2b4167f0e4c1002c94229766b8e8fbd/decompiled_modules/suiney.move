module 0xf79de963ae248ad33395f0e1798472baa2b4167f0e4c1002c94229766b8e8fbd::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 6, b"Suiney", b"Sydney Suiney", b"Sydney. Enough said.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiney_11_56_44a_AM_706ea1efc9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

