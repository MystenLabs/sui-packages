module 0x8147899fce0a71044e476a0031f7fa0f2f725d9f1ae459d180b2a672b0c457d5::ap {
    struct AP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AP>(arg0, 9, b"AP", b"Animal pro", b"We protect of injuries animal. Please protect us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a557c4d8-b64b-4c27-a121-ca995b76c6be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AP>>(v1);
    }

    // decompiled from Move bytecode v6
}

