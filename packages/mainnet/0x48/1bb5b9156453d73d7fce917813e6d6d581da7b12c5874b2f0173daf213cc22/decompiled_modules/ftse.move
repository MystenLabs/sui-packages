module 0x481bb5b9156453d73d7fce917813e6d6d581da7b12c5874b2f0173daf213cc22::ftse {
    struct FTSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTSE>(arg0, 6, b"FTSE", b"FTSE6900", b"IN GOD WE TRUST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1221_72a154d0c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

