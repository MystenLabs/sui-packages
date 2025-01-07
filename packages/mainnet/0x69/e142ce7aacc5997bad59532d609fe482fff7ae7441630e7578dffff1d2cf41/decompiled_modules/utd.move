module 0x69e142ce7aacc5997bad59532d609fe482fff7ae7441630e7578dffff1d2cf41::utd {
    struct UTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTD>(arg0, 9, b"UTD", b"UNITED", b"UNITED TOGATHER ALWAYS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/edf4798f-ec69-4bd8-a642-039cc090d771.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

