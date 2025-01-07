module 0x6aa54a4c59bc107d85da49475e8a2179ee242bb31a6ce71eb0adecb1282484cd::ap {
    struct AP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AP>(arg0, 9, b"AP", b"Animal pro", b"We protect of injuries animal. Please protect us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e079ba6c-28c0-4a1b-af65-db64b3032b7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AP>>(v1);
    }

    // decompiled from Move bytecode v6
}

