module 0xa0e1c4b7066f7b21fd2d9caf901d8430a5873ad371c802211b750ebb1236966e::boobscoin {
    struct BOOBSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBSCOIN>(arg0, 9, b"BOOBSCOIN", b"BOOBS", b"Boobs is life=Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e914b2f-5922-4d0f-86d5-16349a59ac75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOBSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

