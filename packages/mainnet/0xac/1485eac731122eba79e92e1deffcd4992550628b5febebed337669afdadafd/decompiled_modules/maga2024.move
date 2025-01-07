module 0xac1485eac731122eba79e92e1deffcd4992550628b5febebed337669afdadafd::maga2024 {
    struct MAGA2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA2024>(arg0, 6, b"MAGA2024", b"TRUMP VANCE", b"Bullish narrative here in $MAGA2024, once TRUMP and VANCE win the election, $MAGA2024 will gonna be big with ELON MUSK support ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_20_14_58_4af94ba113.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

