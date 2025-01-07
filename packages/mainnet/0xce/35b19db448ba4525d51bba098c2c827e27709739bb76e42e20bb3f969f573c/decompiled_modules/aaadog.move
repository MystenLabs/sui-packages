module 0xce35b19db448ba4525d51bba098c2c827e27709739bb76e42e20bb3f969f573c::aaadog {
    struct AAADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADOG>(arg0, 9, b"AAADOG", b"AAAdoggo", b"AAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26fdcd99-bfb4-4973-92c9-3af3a6a82cd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

