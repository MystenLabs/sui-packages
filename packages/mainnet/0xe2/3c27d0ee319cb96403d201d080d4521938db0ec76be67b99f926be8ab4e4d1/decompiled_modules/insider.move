module 0xe23c27d0ee319cb96403d201d080d4521938db0ec76be67b99f926be8ab4e4d1::insider {
    struct INSIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDER>(arg0, 6, b"Insider", b"Sui insider", b"TRUST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hacker_Thumb_a1_aa391cdb1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

