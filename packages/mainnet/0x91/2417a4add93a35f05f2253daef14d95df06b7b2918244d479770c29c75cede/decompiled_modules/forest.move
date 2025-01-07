module 0x912417a4add93a35f05f2253daef14d95df06b7b2918244d479770c29c75cede::forest {
    struct FOREST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOREST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOREST>(arg0, 9, b"FOREST", b"goysash", b"Tree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/123cf362-f2ba-4dab-bcab-bdfbdb0d8da0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOREST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOREST>>(v1);
    }

    // decompiled from Move bytecode v6
}

