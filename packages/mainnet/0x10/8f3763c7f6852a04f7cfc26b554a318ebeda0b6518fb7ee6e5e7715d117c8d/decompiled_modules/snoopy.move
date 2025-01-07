module 0x108f3763c7f6852a04f7cfc26b554a318ebeda0b6518fb7ee6e5e7715d117c8d::snoopy {
    struct SNOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPY>(arg0, 6, b"SNOOPY", b"NASA Mascot", b"This is snoopy. He leads NASA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NASA_9923ed29fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

