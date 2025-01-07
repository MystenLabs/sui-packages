module 0xa9850d6eeaabccba4941fe695bd1662d02f66c5d6762dbda78211083187cf346::rfs {
    struct RFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFS>(arg0, 6, b"RFS", b"Rug free", b"No pulling here, the rug stays strong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0026_eb52eefc2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

