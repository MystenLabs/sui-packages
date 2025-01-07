module 0x943bc7c536e29dd6be469557836143bcd3d5d3f21009945ed7317552b0b014f::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 6, b"Dsui", b"Ducksui", b"The best meme of Sui, tired of the routine memes Ducksui is funny and fresh, no more cats or dogs or fish, no more Pepe of any color", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_duck_f06a233e05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

