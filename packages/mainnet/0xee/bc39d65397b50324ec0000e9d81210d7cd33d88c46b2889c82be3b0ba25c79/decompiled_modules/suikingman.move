module 0xeebc39d65397b50324ec0000e9d81210d7cd33d88c46b2889c82be3b0ba25c79::suikingman {
    struct SUIKINGMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKINGMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKINGMAN>(arg0, 6, b"SuiKingMan", b"KingMan", x"54686572652773206e6f207465616d206f7220726f61646d617020686572652e204b696e674d616e2074687269766573206f6e2072616e646f6d6e65737320616e642068756d6f720a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/32_4595bc24b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKINGMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKINGMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

