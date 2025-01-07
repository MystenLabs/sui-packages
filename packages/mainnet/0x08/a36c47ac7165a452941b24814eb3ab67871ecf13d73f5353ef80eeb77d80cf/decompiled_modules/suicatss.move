module 0x8a36c47ac7165a452941b24814eb3ab67871ecf13d73f5353ef80eeb77d80cf::suicatss {
    struct SUICATSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATSS>(arg0, 9, b"SUICATSS", b"SUICATSS", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATSS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATSS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

