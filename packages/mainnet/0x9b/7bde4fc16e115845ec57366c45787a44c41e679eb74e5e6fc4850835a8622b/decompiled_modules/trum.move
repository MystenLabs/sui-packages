module 0x9b7bde4fc16e115845ec57366c45787a44c41e679eb74e5e6fc4850835a8622b::trum {
    struct TRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUM>(arg0, 9, b"TRUM", b"TRUMP", b"This is trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d5244bd-e13a-45ae-8418-ad52a8c4543e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

