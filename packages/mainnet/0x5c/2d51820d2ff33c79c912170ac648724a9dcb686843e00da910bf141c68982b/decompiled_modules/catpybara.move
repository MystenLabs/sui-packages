module 0x5c2d51820d2ff33c79c912170ac648724a9dcb686843e00da910bf141c68982b::catpybara {
    struct CATPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATPYBARA>(arg0, 9, b"CATPYBARA", b"CapyMew", b"A Cappybara inside a Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30acf019-aaf8-41b3-a9f3-b3b71f5d9220.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

