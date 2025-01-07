module 0x3f35866db64eed2de48f976820556f4a128d088925bce5b0b92bad14a3464ad5::presents {
    struct PRESENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESENTS>(arg0, 6, b"PRESENTS", b"Santa's  New Bag", b"Santa here. I'm broke. Buy $PRESENTS or Christmas is CANCELED.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aj_Udor9_M_400x400_8cadd689ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESENTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRESENTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

