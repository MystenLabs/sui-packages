module 0x47e27e6e4c9ea452e036661c0557c7e365b366e9151d1fa5d850196b2b911128::wewei {
    struct WEWEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEI>(arg0, 9, b"WEWEI", b"Wewe", b"Dekel ekwk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd153af4-4d81-452b-9a3e-179dd26eb301.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

