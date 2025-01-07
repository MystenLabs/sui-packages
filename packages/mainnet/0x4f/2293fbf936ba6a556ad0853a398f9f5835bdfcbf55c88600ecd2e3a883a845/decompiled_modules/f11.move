module 0x4f2293fbf936ba6a556ad0853a398f9f5835bdfcbf55c88600ecd2e3a883a845::f11 {
    struct F11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: F11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F11>(arg0, 9, b"F11", b"ft", b"have a nice day ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/205ccf7d-dc79-4484-828b-59d921361b7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F11>>(v1);
    }

    // decompiled from Move bytecode v6
}

