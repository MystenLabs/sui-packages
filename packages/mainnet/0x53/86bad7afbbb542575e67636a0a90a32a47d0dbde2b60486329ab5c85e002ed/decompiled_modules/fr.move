module 0x5386bad7afbbb542575e67636a0a90a32a47d0dbde2b60486329ab5c85e002ed::fr {
    struct FR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FR>(arg0, 9, b"FR", b"Gfr", b"Minimal latest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e925a600-1e09-4771-ba9e-ab3ab632b2b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FR>>(v1);
    }

    // decompiled from Move bytecode v6
}

