module 0xd2d260709caf148c25099007e91ebb1c525fdcfba9acae5e444e5f032b031176::adasin {
    struct ADASIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADASIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADASIN>(arg0, 9, b"ADASIN", b"Aliyu ja.a", b"This is my first token launched on the SUI blockchain. Bullish all the way up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a58b50c-f993-4e9b-9f16-182701a8edcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADASIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADASIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

