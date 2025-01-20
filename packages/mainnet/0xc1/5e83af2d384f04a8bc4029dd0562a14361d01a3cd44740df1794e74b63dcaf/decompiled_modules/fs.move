module 0xc15e83af2d384f04a8bc4029dd0562a14361d01a3cd44740df1794e74b63dcaf::fs {
    struct FS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FS>(arg0, 6, b"FS", b"Fuck scammers  by SuiAI", b"Don't trust me .I might be one of them ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000048842_4947b78eea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

