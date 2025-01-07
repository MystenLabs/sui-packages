module 0x4e3b27bba36c0aa22e77093d40321389e41df7c7612e572bc1a7de04326dabd1::luiko {
    struct LUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUIKO>(arg0, 6, b"Luiko", b"LuikoSui", b"LuikoLuikoLuikoLuiko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_5_e249c43d0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

