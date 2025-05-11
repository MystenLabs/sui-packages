module 0xb9ccdc0475d82f3eaccf1cd74c1a42795f139e20735c2246846fc83ac224d644::loyalty {
    struct LOYALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOYALTY>(arg0, 9, b"LOYALTY", b"CyDog X-01", b"CyberDog X-01, blending advanced AI engineering with sleek, modern aesthetics. Its aerodynamic black armor, illuminated by neon blue circuits, symbolizes the convergence of technology and loyalty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efe6f829-075b-4508-b6b6-61a295f31349.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOYALTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOYALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

