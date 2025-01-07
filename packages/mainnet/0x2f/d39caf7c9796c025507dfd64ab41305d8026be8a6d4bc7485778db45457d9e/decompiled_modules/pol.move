module 0x2fd39caf7c9796c025507dfd64ab41305d8026be8a6d4bc7485778db45457d9e::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 9, b"POL", b"EAR", b"EAR PLEASING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b92dc6a-b6b3-47f1-8b1b-336781576f13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POL>>(v1);
    }

    // decompiled from Move bytecode v6
}

