module 0x25dfdd7f253ae5fd27d0adbdd10dd40af63be6020670ff4a77c51977ea2c8960::noi {
    struct NOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOI>(arg0, 9, b"NOI", b"Noion", b"Token noi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d66ded88-b663-426b-a61d-c5ce35250fef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

