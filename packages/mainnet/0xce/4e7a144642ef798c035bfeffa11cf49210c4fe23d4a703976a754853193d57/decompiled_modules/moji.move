module 0xce4e7a144642ef798c035bfeffa11cf49210c4fe23d4a703976a754853193d57::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"MOJI ON SUI", x"244d4f4a49202d20205468652042696720507572706c6520456d6f6a690a5374617274696e672074686520656d6f6a692d6669206d657461206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_S_Gt6_B_Ur_400x400_4d7e8f84a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

