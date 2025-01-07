module 0xbefeb3f89bcbc07ba05172038f0844605a0918823bd9dcd23d58e16bbc240479::wormy {
    struct WORMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMY>(arg0, 6, b"Wormy", b"Worm", b" worm worm worm worm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6766_9fe231aa54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

