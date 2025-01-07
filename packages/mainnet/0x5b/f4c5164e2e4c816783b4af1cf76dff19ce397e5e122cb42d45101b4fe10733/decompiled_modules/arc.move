module 0x5bf4c5164e2e4c816783b4af1cf76dff19ce397e5e122cb42d45101b4fe10733::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARC>(arg0, 9, b"ARC", b"ARC ELBAF", b"Road to One Piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85388a5f-ef39-4b5b-a4f9-568fa79cd3f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

