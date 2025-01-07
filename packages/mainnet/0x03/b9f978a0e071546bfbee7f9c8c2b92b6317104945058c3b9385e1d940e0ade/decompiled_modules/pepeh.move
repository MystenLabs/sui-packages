module 0x3b9f978a0e071546bfbee7f9c8c2b92b6317104945058c3b9385e1d940e0ade::pepeh {
    struct PEPEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEH>(arg0, 9, b"PEPEH", b"Pepe Hat", b"Kids with Pepe Hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7295df0-d286-4388-8e83-2535c464ee20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

