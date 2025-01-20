module 0xfd32f12d6dc6a7f62c7e90bb7d748edbe3537639ba10340b767cfceeba70e4dc::zuckerberg {
    struct ZUCKERBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCKERBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCKERBERG>(arg0, 6, b"ZUCKERBERG", b"Mark Zuckerberg", b"Mark Zuckerberg being caught at Donald Trumps inauguration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_21_030118_06fb87ffeb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCKERBERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUCKERBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

