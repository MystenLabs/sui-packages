module 0x655f2d361af0a60e597ab0862292ab491fa6de92989dff7790f881e9f9725131::shuigure {
    struct SHUIGURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIGURE>(arg0, 6, b"SHUIGURE", b"ShuigureOnSui", b"Watch my 9MM go bang!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000377_3d8faf1411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIGURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIGURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

