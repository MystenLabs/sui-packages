module 0x485a0d06bb0084c61c7ec1f16fa566b65206cf6c3427139ad7c2307ca990d060::nikz {
    struct NIKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKZ>(arg0, 9, b"NIKZ", b"Nikzo", b"An inspired newbea in the crypto space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2e23223-9528-454f-81f3-583cf09d9ebe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

