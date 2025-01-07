module 0x73cdd1bfe0d28d76acbdb55758ef3da0c4e2f3341a2cda4902c9f62012100641::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 6, b"BEER", b"SUI BEER", b"$BEER brings people together and creates lasting memories.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_07_37_26_c998423de7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

