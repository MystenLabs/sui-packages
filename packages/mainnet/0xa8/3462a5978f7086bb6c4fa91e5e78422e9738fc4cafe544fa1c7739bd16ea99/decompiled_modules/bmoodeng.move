module 0xa83462a5978f7086bb6c4fa91e5e78422e9738fc4cafe544fa1c7739bd16ea99::bmoodeng {
    struct BMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOODENG>(arg0, 6, b"bMooDeng", b"BabyMooDeng", b"Baby Moo Deng On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009616_e488f12b52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

