module 0x1ff903e3dcb5ed4ed11b44450603b9dc02b6fa811d2b0278b69aa4057f37fea8::gmsui {
    struct GMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMSUI>(arg0, 6, b"GMSUI", b"gm to sui", b"gm to sui  ultimate orgy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_483c1db961.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

