module 0x95432929d40eb097a85c102808025f6623f52656073f428c4f492e6f672ef537::zozo {
    struct ZOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOZO>(arg0, 6, b"Zozo", b"ZoltanInu", b"Yes !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wn_TS_TGW_400x400_1fb50186a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

