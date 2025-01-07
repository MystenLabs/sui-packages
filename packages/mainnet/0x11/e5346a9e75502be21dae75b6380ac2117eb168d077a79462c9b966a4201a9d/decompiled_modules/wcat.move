module 0x11e5346a9e75502be21dae75b6380ac2117eb168d077a79462c9b966a4201a9d::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 9, b"WCAT", b"WeweCat", b"WeweCat is not just memecoin,its a special memecoin that can pump as you dream in your childhood stories.so hope you will have great time with this chance of pumpation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a57ca798-5298-4433-95d5-ae1d9f6c7c65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

