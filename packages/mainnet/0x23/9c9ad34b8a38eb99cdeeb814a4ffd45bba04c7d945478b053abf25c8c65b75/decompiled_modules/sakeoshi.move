module 0x239c9ad34b8a38eb99cdeeb814a4ffd45bba04c7d945478b053abf25c8c65b75::sakeoshi {
    struct SAKEOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKEOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKEOSHI>(arg0, 9, b"Sakeoshi", b"Sake", b"Sake Oshita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20190921/original/pngtree-colorful-japanese-wine-glass-bottle-illustration-png-image_4758854.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAKEOSHI>(&mut v2, 18000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKEOSHI>>(v2, @0x3e6f93f81e9cc2660e8eb52283f5c8c06c04abc6920ffa99bd849d3da0ddccee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKEOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

