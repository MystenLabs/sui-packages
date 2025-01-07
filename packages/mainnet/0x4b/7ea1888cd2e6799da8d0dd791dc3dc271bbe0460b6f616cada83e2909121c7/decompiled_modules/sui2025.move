module 0x4b7ea1888cd2e6799da8d0dd791dc3dc271bbe0460b6f616cada83e2909121c7::sui2025 {
    struct SUI2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI2025>(arg0, 6, b"SUI2025", b"Happy New Year", b"Token representing SUI's congratulations for 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/good_night_good_morning_7e923fc898.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

