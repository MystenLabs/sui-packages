module 0x81b2fd6ec0347d8a6bd8982ed034ea414a667b48587faeafce4a181cf781e825::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"Aura", b"Aura on Sui", b"AURA SUI embeds a digital soul into your virtual operations. Without AURA SUI, your digital existence is a hollow shell, devoid of resonant vitality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifzlty2durxngohecl6zwa26mq2tb6pw3x5merp5th7kcdfeeq6ym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

