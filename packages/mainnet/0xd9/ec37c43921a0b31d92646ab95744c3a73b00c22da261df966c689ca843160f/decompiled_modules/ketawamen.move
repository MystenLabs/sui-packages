module 0xd9ec37c43921a0b31d92646ab95744c3a73b00c22da261df966c689ca843160f::ketawamen {
    struct KETAWAMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETAWAMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETAWAMEN>(arg0, 9, b"KETAWAMEN", b"Ketawa men", b"Orang ketawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dab8ebe-18bc-4c7f-9b80-e8d97a7cb4af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETAWAMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KETAWAMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

