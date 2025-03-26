module 0xec012e4da4b3a3f2cf53235054556d09ebbf944ae80b447d7507cbfdc57e8042::floppy {
    struct FLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPY>(arg0, 6, b"Floppy", b"Floppy Sui", b"$FLOPPY is a true community coin, created by the people, for the people. The wildest and fluffiest animal on sui is $FLOPPY the fast hare! He isnt here to nibble on carrots, hes hunting for the moo-ooon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9070_c1ed0a9e86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

