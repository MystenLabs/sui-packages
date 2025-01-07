module 0xb4dc0e65c6a85aac5f8ba5b68da100586e7cd7873666ec2a60996bfe74da3069::mewsui {
    struct MEWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWSUI>(arg0, 9, b"MEWSUI", b"JustinMoon", b"Mew mew mew !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c708e2b5-92af-423d-aa94-aebbba8282b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

