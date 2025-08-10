module 0xcf1f19d453640a289239d43cad39d3ed75193dee6d38d86d7d936966a429a04d::lnx {
    struct LNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNX>(arg0, 6, b"LNX", b"Linux", b"Satoshi Nakamoto's Favourite Operating System", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LNX_bb572f6b8e.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

