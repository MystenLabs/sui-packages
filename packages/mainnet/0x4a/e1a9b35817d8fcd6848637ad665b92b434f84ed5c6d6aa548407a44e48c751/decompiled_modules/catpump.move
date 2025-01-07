module 0x4ae1a9b35817d8fcd6848637ad665b92b434f84ed5c6d6aa548407a44e48c751::catpump {
    struct CATPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATPUMP>(arg0, 9, b"CATPUMP", x"6b68e1baa369", b"yff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/286e088f-1545-488d-a5db-03a1a5826c31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

