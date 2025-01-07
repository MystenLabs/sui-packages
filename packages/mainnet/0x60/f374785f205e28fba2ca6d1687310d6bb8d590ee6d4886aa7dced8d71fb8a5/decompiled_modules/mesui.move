module 0x60f374785f205e28fba2ca6d1687310d6bb8d590ee6d4886aa7dced8d71fb8a5::mesui {
    struct MESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESUI>(arg0, 6, b"MESUI", b"MemeSUI", b"$MESUI | Communities Token. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088303_a51eb9d25c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

