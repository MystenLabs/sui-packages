module 0x9dcd4323adc0a771ab7710a0909676e9ca4d0b22d2c98576ff8f83dc92176322::axl {
    struct AXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXL>(arg0, 9, b"AXL", b"Axolotl", b"Axolotl in minecraft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0e16472-db24-4dd8-9960-adce38decca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

