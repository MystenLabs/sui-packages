module 0xd4c227af86d18ffb0a163e9dfd9a19351bf5f5fd0f6db66a51ef2c0de9abb64e::blaze {
    struct BLAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZE>(arg0, 6, b"Blaze", b"Blaze on Sui", x"444f204e4f54204255592054484953204f4e4521204f4646494349414c204c41554e43482049532030392f3239203132504d205554430a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blaze_profile_808a33f841.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

