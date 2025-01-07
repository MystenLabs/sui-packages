module 0xdbf2d9b6f21ace78c92f1cdcc0d456b5464d1a86f3d83c0d7798f40a274801b6::mdk {
    struct MDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDK>(arg0, 9, b"MDK", b"Mooduk", b"So cute bro moodeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd9f7918-be52-4b79-a040-ba6ca47c0a43-1000005297.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

