module 0x1cc2c54bd9c23b7abee7fd38ad4ecbb122a34049e11a3879236c548f45525ee8::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 9, b"TRP", b"TrUmP", b"Trump Coin is a unique cryptocurrency inspired by American values and history. It symbolizes strength, independence, and innovation. By investing in Trump Coin, you support financial freedom and become part of the future of technology and entrepreneurship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/774df901-1a41-410f-8de5-8a18d0f74401.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

