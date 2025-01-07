module 0x2eb865b12707e5cf9c8ede2c22209f2f828fba85329e8350d7a792cd7c3fd367::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 9, b"FUD", b"FED", b"Vonglaptaiching", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcf3fa0b-fd18-4c1d-a787-37831d87e08b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

