module 0xfcf92002862acd220715b554ab3f9fed2517c1e14cb58251d57645c8019458d3::cato {
    struct CATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATO>(arg0, 9, b"CATO", b"Cat", b"Cute cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e80e617-ce43-4856-95a2-670a2b2737c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

