module 0x85371a32108556af287fffbbee22e272670b67ad3d43874e29777b57347b04d8::hopbunnys {
    struct HOPBUNNYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPBUNNYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPBUNNYS>(arg0, 6, b"Hopbunnys", b"Hop bunny sui", b"Dex is Updated Take Early ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9314_4a7dd8a116.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPBUNNYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPBUNNYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

