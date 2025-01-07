module 0x90fc1d421401a55a2f0457ec9cfe96a7fad305c6ddd90170a71eae6d3e5be016::torba {
    struct TORBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORBA>(arg0, 9, b"TORBA", b"torba", b"Real Torba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a715e634-ec13-4e83-ab02-413489fa5a88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

