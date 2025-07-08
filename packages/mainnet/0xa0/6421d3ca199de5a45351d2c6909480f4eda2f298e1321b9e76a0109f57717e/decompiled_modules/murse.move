module 0xa06421d3ca199de5a45351d2c6909480f4eda2f298e1321b9e76a0109f57717e::murse {
    struct MURSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURSE>(arg0, 6, b"MURSE", b"Sui murse", b"$MURSE is an eccentric dog with a modern style appearance, ready to cause chaos but actually cautious.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087056_51205dc59c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

