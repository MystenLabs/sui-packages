module 0xe937de3e396138682147c9b87202dae43acbf68fb491534ae018c5d7356cba7b::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 9, b"HH", b"Ty", b"Ghn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34cdfe2f-1561-4be8-b38e-a95299a9e7ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HH>>(v1);
    }

    // decompiled from Move bytecode v6
}

