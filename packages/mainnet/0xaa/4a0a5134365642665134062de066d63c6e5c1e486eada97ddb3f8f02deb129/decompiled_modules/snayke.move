module 0xaa4a0a5134365642665134062de066d63c6e5c1e486eada97ddb3f8f02deb129::snayke {
    struct SNAYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAYKE>(arg0, 6, b"SNAYKE", b"SNAYKEMEME", x"6b696e67206f662074686520636c617920636162616c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4000202774_81b5b99fb4.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAYKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAYKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

