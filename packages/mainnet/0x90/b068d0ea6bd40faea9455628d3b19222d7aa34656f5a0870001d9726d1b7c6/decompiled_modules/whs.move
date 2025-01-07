module 0x90b068d0ea6bd40faea9455628d3b19222d7aa34656f5a0870001d9726d1b7c6::whs {
    struct WHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHS>(arg0, 9, b"WHS", b"WAR HORSE", b"WINNING ALL THE BATTLES WITH WAR HORSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f8b8f03-0f80-48cb-b154-2d8248e47f4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

