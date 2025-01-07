module 0x30b75609875fe9cd813a5a7a19badd3dda77c464a1717ab504121b7dedcdd2f5::ap {
    struct AP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AP>(arg0, 9, b"AP", b"Animal pro", b"We protect of injuries animal. Please protect us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be75b7ab-6f87-47c3-9210-60bed2cbc60c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AP>>(v1);
    }

    // decompiled from Move bytecode v6
}

