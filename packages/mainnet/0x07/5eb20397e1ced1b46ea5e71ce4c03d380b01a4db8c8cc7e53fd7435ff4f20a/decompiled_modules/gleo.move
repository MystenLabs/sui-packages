module 0x75eb20397e1ced1b46ea5e71ce4c03d380b01a4db8c8cc7e53fd7435ff4f20a::gleo {
    struct GLEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLEO>(arg0, 6, b"GLEO", b"Gleo", x"4a7573742063616c6c2074686174206d6967687479206561676c6520676c656f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052242_4cdd6635fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

