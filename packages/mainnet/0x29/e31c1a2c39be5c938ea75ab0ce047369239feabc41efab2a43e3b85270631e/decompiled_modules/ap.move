module 0x29e31c1a2c39be5c938ea75ab0ce047369239feabc41efab2a43e3b85270631e::ap {
    struct AP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AP>(arg0, 9, b"AP", b"Animal pro", b"We protect of injuries animal. Please protect us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7808e190-f6db-4013-9661-b39fd443ede7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AP>>(v1);
    }

    // decompiled from Move bytecode v6
}

