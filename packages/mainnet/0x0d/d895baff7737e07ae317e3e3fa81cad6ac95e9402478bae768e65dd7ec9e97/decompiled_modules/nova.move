module 0xdd895baff7737e07ae317e3e3fa81cad6ac95e9402478bae768e65dd7ec9e97::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"NovaFlux", b"NovaFlux is the gateway to the next generation of decentralized finance. Designed for speed, security, and scalability, $NOVA powers an ecosystem where users can trade, stake, and grow with ease. With innovative features like AI-driven insights and c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737101229326.29")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

