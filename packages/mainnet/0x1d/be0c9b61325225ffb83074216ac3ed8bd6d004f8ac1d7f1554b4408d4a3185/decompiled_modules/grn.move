module 0x1dbe0c9b61325225ffb83074216ac3ed8bd6d004f8ac1d7f1554b4408d4a3185::grn {
    struct GRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRN>(arg0, 9, b"GRN", b"Green", b"Like ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/346bb0b0-3eba-4d83-a98d-25ec4cf25e81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

