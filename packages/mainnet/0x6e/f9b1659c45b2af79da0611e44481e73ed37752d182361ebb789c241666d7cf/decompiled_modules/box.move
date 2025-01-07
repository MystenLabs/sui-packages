module 0x6ef9b1659c45b2af79da0611e44481e73ed37752d182361ebb789c241666d7cf::box {
    struct BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOX>(arg0, 6, b"BOX", b"SUI.BOX", b"Sui $BOX is the character symbol of the Sui blockchain, which appears simple and unique but is full of hidden potential and surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lg_f9251d729c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

