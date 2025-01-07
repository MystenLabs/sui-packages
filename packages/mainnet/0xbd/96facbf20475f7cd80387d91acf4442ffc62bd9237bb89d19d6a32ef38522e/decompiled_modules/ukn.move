module 0xbd96facbf20475f7cd80387d91acf4442ffc62bd9237bb89d19d6a32ef38522e::ukn {
    struct UKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UKN>(arg0, 9, b"UKN", b"UNKNOWN", b"UNKNOWN MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f712f3a6-9575-408a-9970-e73bd0bc7a45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

