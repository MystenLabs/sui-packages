module 0xd72e7382b4a0abfec6b2721222fc42493621d296d6e1728b06682728ddf520d4::ahmad {
    struct AHMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHMAD>(arg0, 9, b"AHMAD", b"Muhammad", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2818d2a-3bd8-4df1-a78c-a1afc896e06d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

