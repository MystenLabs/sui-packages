module 0x6bcb14b23c3500257beb5ff8270227e977043cb702ec7fa03104cd43142f9b6d::cdb {
    struct CDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDB>(arg0, 9, b"CDB", b"CODEDBOIS", b"For the homies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30188b8a-cd10-465c-8710-d09d173bf4a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

