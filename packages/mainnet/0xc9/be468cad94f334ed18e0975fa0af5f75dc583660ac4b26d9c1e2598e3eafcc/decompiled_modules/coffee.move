module 0xc9be468cad94f334ed18e0975fa0af5f75dc583660ac4b26d9c1e2598e3eafcc::coffee {
    struct COFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEE>(arg0, 9, b"COFFEE", b"Sui Coffee", b"come on sui community stop buying other shit tokens let's buy coffee tokens right now and get our coffee for free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1659662190129840128/OEGExsWk_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COFFEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFFEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

