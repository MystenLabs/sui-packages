module 0xf436e76eb460e7b22d45f26ef74839e4d25d5c352275015259cac86aefbc9d4::insora {
    struct INSORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSORA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<INSORA>(arg0, 6, b"INSORA", b"Insora AI by SuiAI", b"Unlock the Future of Automated Trading with Insora AI Where Technology Meets Profitability. Invest Today and Earn Tomorrow.Maximize Your Returns with Cutting-Edge Algorithmic Trading Bots..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737811300686_7674b559e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INSORA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSORA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

