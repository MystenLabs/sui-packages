module 0x10899a57f6564d0b68989588f366c9bcfeb1c9481451580b75694252e40fc95d::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"Official ELON on Sui by SuiAI", b"$ELON - The only official Elon coin meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Q0_I_Rid_Se_400x400_80de0dbffa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

