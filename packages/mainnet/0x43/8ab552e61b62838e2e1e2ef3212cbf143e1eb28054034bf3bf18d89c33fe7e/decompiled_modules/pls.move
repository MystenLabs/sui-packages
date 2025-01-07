module 0x438ab552e61b62838e2e1e2ef3212cbf143e1eb28054034bf3bf18d89c33fe7e::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 9, b"PLS", b"PULSECHAIN", b"FORK OF ETHEREUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a979d7d-6a69-4d16-8336-21805999c56d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

