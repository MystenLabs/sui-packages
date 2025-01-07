module 0x8eb29e474cc701b76fb2da19d83c0d5728514c59c8c0545fe31303757b83392d::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 9, b"MOVE", b"Nanamove", b"Uwayuri", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/423fde8d-ef08-406b-aab7-542c8ff59b89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

