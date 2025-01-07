module 0xcd549fad7cdf1b59553f4d1a5f35a80b0de09ee553631ea232510c0ff4e6798::peju {
    struct PEJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEJU>(arg0, 9, b"PEJU", b"Peju SUI", b"Peju peju peju", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b55fc317-9d9e-4c1e-ac88-9b64bb53698e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEJU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEJU>>(v1);
    }

    // decompiled from Move bytecode v6
}

