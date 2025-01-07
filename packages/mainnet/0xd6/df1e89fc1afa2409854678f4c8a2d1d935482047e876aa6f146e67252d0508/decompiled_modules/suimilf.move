module 0xd6df1e89fc1afa2409854678f4c8a2d1d935482047e876aa6f146e67252d0508::suimilf {
    struct SUIMILF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMILF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMILF>(arg0, 6, b"SUIMILF", b"Move Pump MILF", b"Everyone wants a MILF even better when is a $SUIMILF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_84_removebg_preview_7c6203f627.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMILF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMILF>>(v1);
    }

    // decompiled from Move bytecode v6
}

