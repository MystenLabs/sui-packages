module 0x78b14824e94c00f1baf910bfe5cab6064806ac62181a6d834f976595ad80beaf::vi {
    struct VI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VI>(arg0, 9, b"VI", b"ViVA", b"Exciting project with a lot of opportunities ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39c83a43-0cfe-4af5-8254-270896a05dd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VI>>(v1);
    }

    // decompiled from Move bytecode v6
}

