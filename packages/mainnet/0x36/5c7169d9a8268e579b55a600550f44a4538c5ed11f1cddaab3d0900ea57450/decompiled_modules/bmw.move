module 0x365c7169d9a8268e579b55a600550f44a4538c5ed11f1cddaab3d0900ea57450::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMW>(arg0, 9, b"BMW", b"BMW Fans", b"Fans auto BMW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42ad410f-b213-47c0-93e4-9b14e10044c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

