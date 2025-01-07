module 0x675f6490ac91be0cf518363af4b432a9c8e1c17518677cde570a9d107fbb9dd8::sario {
    struct SARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARIO>(arg0, 6, b"SARIO", b"Sui Shotgun Mario", x"496e74726f647563696e67205375692053686f7467756e20536172696f2e204669727374204d656d65636f696e20382d62697420616476656e74757265206f6e205375692e20496e73706972656420627920636c6173736963204d6172696f2076696265732c207468697320746f6b656e206272696e677320796f752074686520756c74696d6174652067616d696e6720657870657269656e6365207768657265204d6172696f20626174746c6573206d6f6e737465727320776974682073686f7467756e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sario_Final_2bb3e157a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

