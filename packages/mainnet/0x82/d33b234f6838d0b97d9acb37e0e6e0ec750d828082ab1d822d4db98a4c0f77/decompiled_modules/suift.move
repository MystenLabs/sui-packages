module 0x82d33b234f6838d0b97d9acb37e0e6e0ec750d828082ab1d822d4db98a4c0f77::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"SUIFT", b"TAYLOR SUIFT", b"Taylor Swift, but SUI version.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/166387d855188efe2d0e7d9e4df16bd0_f5c7d3a4d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

