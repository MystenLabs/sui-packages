module 0xfa3354689aebcf6d93ec33b2e26547dea16e921b38788b9870c732727a86bb9b::pck {
    struct PCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCK>(arg0, 9, b"PCK", b"GREEN peac", b"the green peacock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dcbe13a-3447-46e7-a5b9-8d4cff9001b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

