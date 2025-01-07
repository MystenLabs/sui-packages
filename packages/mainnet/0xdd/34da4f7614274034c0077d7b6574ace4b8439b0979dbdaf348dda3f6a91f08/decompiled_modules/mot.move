module 0xdd34da4f7614274034c0077d7b6574ace4b8439b0979dbdaf348dda3f6a91f08::mot {
    struct MOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOT>(arg0, 9, b"MOT", b"TokenMot", b"Mottokrnmotkhong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f18f2a43-50cd-4347-bb6f-565948229607.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

