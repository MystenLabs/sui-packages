module 0x3593a7b571a35ae21d0e632b193ba2ac914a1642c5781c1bae10b88077f33e52::snoop {
    struct SNOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOP>(arg0, 6, b"Snoop", b"Snoop Crab", b"He's a crab and he's getting high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_joint_7ab0280bfa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

