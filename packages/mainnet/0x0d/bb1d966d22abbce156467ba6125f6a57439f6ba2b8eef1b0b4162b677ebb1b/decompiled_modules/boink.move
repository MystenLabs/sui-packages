module 0xdbb1d966d22abbce156467ba6125f6a57439f6ba2b8eef1b0b4162b677ebb1b::boink {
    struct BOINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOINK>(arg0, 9, b"BOINK", b"BOINKERS", x"f09fa4aa204368617365207468652073747570696420647265616d206f662067657474696e6720746f20746865206d6f6f6e206279206661726d696e672074686520756c74696d6174652067616d65206d656d65636f696e2c2024424f494e4b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8572c1dc-1ae3-4459-9b73-3a6b12ee1e70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

