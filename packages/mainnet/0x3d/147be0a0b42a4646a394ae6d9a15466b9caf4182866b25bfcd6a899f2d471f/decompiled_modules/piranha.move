module 0x3d147be0a0b42a4646a394ae6d9a15466b9caf4182866b25bfcd6a899f2d471f::piranha {
    struct PIRANHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRANHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRANHA>(arg0, 6, b"Piranha", b"Piranha on Sui", b"Small but fierce, $PIRANHA is all about ruthless speed and sharp moves in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piranha_9f6c8fa304.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRANHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRANHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

