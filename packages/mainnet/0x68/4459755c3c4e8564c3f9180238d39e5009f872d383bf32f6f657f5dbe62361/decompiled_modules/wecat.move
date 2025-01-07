module 0x684459755c3c4e8564c3f9180238d39e5009f872d383bf32f6f657f5dbe62361::wecat {
    struct WECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECAT>(arg0, 9, b"WECAT", b"Wewe", b"Wewe token is a cryptocurrency named after characters, individuals, animals, artwork, or anything else in an attempt to be humorous, light-hearted, and attract a user base by promising a fun community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/937b1d75-2f93-4589-9da2-b1c319edf195.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

