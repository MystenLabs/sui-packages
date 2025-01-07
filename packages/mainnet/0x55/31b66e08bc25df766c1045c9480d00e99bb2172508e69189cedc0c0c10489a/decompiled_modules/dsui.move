module 0x5531b66e08bc25df766c1045c9480d00e99bb2172508e69189cedc0c0c10489a::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 6, b"DSUI", b"Digsui", b"Dig Dig Dig keep Diging!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/erwrfwe_68d4699b9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

