module 0xaaaa9f7592cfbb47a0f74d9c2c9b18f801475b95f1be383b3fe2fcceea058d16::fsl {
    struct FSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSL>(arg0, 6, b"FSL", b"Full Sail", b"The DEX on @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lndsj_Mm4_400x400_f033cf99ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

