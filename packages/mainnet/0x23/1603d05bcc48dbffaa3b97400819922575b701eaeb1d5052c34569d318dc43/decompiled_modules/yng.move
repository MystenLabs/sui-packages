module 0x231603d05bcc48dbffaa3b97400819922575b701eaeb1d5052c34569d318dc43::yng {
    struct YNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YNG>(arg0, 9, b"YNG", b"moroz ", b"top product ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a69d1ea-142f-43ee-a3a3-a7b7efb2d169.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

