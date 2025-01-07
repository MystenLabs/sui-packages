module 0x63d4ed885507085622ecef0990951f6baf54b1d11dc1f9f51e9c05fcd7da3d2b::buybinky {
    struct BUYBINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYBINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYBINKY>(arg0, 6, b"BUYBINKY", b"BUY BINKY", b"BUY BINKY, NOW ON BLUEMOVE. JOIN THE TG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_3fa0171aca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYBINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUYBINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

