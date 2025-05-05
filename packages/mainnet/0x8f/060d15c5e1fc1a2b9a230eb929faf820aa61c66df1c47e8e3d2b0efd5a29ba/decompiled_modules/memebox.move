module 0x8f060d15c5e1fc1a2b9a230eb929faf820aa61c66df1c47e8e3d2b0efd5a29ba::memebox {
    struct MEMEBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEBOX>(arg0, 9, b"MEMEBOX", b"ARB", b"ASSSS dsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/bd64b2fa-687c-4fdb-a741-bbcd5d6e1408.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

