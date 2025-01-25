module 0xd6f2851694832772355ebc70b0c9e12cfe1c5a69da15bb2b259f5c91f736bb6e::nokiasnake {
    struct NOKIASNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOKIASNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOKIASNAKE>(arg0, 6, b"NokiaSnake", b"Chinese New Year Nokia Snake", b"Chinese New Year Nokia Snake of 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_25_at_7_59_52a_PM_4a03fd1387.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOKIASNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOKIASNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

