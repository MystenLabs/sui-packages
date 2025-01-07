module 0x5b9e90ff276e302efff5508b5e3c64f1be342024f816ac57645338b204225f0c::suipers {
    struct SUIPERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERS>(arg0, 6, b"Suipers", b"Fuck da Snipers", b"Don't you just hate snipers? Don't buy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_at_11_03_56a_PM_1e9ff99aa8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

