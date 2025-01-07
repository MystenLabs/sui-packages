module 0x58390dbd36f278037d15069813609ceb0457ede1d004a27b128afe283ce22693::suiward {
    struct SUIWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARD>(arg0, 6, b"SUIWARD", b"SuiwardOnSui", b"$SUIWARD Bikini bottom on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_004011_73667df209.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

