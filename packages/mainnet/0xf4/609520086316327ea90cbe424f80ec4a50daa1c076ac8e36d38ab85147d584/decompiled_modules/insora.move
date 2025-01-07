module 0xf4609520086316327ea90cbe424f80ec4a50daa1c076ac8e36d38ab85147d584::insora {
    struct INSORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSORA>(arg0, 6, b"INSORA", b"Insora AI", b"Unlock the Future of Automated Trading with Insora AI Where Technology Meets Profitability. Invest Today and Earn Tomorrow.Maximize Your Returns with Cutting-Edge Algorithmic Trading Bots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b26q_FNVS_400x400_a3542e55ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

