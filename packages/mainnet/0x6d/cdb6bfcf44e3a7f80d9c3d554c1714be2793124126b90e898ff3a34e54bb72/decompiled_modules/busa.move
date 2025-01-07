module 0x6dcdb6bfcf44e3a7f80d9c3d554c1714be2793124126b90e898ff3a34e54bb72::busa {
    struct BUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSA>(arg0, 9, b"BUSA", b"Busa Token", b"Hehe Buka Bisa Busa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc475793-8422-408a-89bb-f12068f21260.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

