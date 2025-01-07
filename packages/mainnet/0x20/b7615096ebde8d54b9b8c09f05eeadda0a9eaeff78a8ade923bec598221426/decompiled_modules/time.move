module 0x20b7615096ebde8d54b9b8c09f05eeadda0a9eaeff78a8ade923bec598221426::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME>(arg0, 9, b"TIME", b"Time", b"Next Time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecd929ce-8f17-4f84-b7e7-f8e856ed1961.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

