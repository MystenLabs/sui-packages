module 0x4ed08fd0d038891857b10a2d5061fee5a02470f4378854537b44d7a472fd41c4::your_name {
    struct YOUR_NAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUR_NAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUR_NAME>(arg0, 9, b"YOUR_NAME", b"Name", x"54686973206e616d65206f6620746f6b656e20697320796f7572206e616d6520f09fabb5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bff16fb7-d6ea-46d4-b41b-88703c8cddae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUR_NAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUR_NAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

