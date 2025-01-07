module 0x217cf13c3f71f6e45df45caa063bab8f75a815b0f78298ab6fc07f358fad6f5::tap {
    struct TAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAP>(arg0, 9, b"TAP", b"TAPsapiens", b"A new kind of human development. TAP sapiens. The time of origin is the 21st century of our era.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d95918f-b209-45e7-9b97-b6a8938699a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

