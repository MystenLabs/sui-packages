module 0xfb613e759e3f613fc103106546e7ded97cd0f33b674291973a3e777b2c8a5fb7::rete {
    struct RETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETE>(arg0, 9, b"RETE", b"Retecon", b"Retekun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/920bf3b3-0ada-4094-9096-e612831405fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

