module 0x503a84fc01dce83756fff13c5e096e135691c0419ed93f42cb7525758f2099ce::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 6, b"Dsui", b"Ducksui", b"The best meme of Sui, tired of the routine memes Ducksui is funny and fresh, no more cats or dogs or fish, no more Pepe of any color", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_duck_17645ea3dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

