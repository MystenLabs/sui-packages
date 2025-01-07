module 0x390092767abcc46f17943afc168a511b584bd2c2cce0b13657f85f38d496a1eb::snife {
    struct SNIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIFE>(arg0, 6, b"SNIFE", b"Shrek Knife", b"I TOLD YOU GET OUT OF MY SWAMP!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1609e8f01b4d27b7f0d52567cb47375c_a806ddaea8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

