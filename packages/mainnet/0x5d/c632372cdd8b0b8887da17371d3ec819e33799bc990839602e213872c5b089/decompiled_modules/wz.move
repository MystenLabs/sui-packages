module 0x5dc632372cdd8b0b8887da17371d3ec819e33799bc990839602e213872c5b089::wz {
    struct WZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZ>(arg0, 6, b"WZ", b"wangzai", b"wangzai milk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731261040161.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

