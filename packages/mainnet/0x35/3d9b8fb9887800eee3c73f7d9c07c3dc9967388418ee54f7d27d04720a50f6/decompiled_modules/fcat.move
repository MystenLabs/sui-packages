module 0x353d9b8fb9887800eee3c73f7d9c07c3dc9967388418ee54f7d27d04720a50f6::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"FCat", b"FishCat", x"50726f7465637420796f757220666973682077656c6cefbc81efbc81efbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000964085.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

