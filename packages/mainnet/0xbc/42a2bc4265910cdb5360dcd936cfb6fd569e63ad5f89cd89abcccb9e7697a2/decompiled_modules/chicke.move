module 0xbc42a2bc4265910cdb5360dcd936cfb6fd569e63ad5f89cd89abcccb9e7697a2::chicke {
    struct CHICKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKE>(arg0, 9, b"CHICKE", b"Sui20", x"54686520656e6a6f7920746865206d656d636f696e206f6620205473756e616d6920666573746976616c20206d6f6f6f6e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68d86dfc-78ff-4f24-a338-ef7219e26d14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

