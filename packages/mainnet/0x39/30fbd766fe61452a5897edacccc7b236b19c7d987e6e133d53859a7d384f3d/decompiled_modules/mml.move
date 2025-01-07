module 0x3930fbd766fe61452a5897edacccc7b236b19c7d987e6e133d53859a7d384f3d::mml {
    struct MML has drop {
        dummy_field: bool,
    }

    fun init(arg0: MML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MML>(arg0, 9, b"MML", b"Memeland", b"Love ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d08c3b97-a4e1-4e9d-bfc4-4b252b26fc4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MML>>(v1);
    }

    // decompiled from Move bytecode v6
}

