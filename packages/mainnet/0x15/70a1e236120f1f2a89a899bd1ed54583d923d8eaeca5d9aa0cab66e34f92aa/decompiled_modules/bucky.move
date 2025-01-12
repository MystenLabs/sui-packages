module 0x1570a1e236120f1f2a89a899bd1ed54583d923d8eaeca5d9aa0cab66e34f92aa::bucky {
    struct BUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKY>(arg0, 6, b"BUCKY", b"BUCKYS", b"Leader of the QUACKHOUSE. $BUCKY: the coin the waddles to greatness. NO roadmap, just vibes and quacks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1996_5a7ff2f511.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

