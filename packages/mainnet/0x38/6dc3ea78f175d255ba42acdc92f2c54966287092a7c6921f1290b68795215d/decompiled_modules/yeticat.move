module 0x386dc3ea78f175d255ba42acdc92f2c54966287092a7c6921f1290b68795215d::yeticat {
    struct YETICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETICAT>(arg0, 6, b"YETICAT", b"YETI CAT", b"A degenerate cat and a yeti made a backwood baby in the mountains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2_8e2be53bcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

