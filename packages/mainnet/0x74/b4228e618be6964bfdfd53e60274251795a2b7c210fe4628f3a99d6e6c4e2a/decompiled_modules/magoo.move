module 0x74b4228e618be6964bfdfd53e60274251795a2b7c210fe4628f3a99d6e6c4e2a::magoo {
    struct MAGOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGOO>(arg0, 6, b"Magoo", b"Mr Magoo", b"Ooooh magoooo youve done it again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/24_FFC_5_BD_E0_C7_4520_8629_8_F48_DAE_3_ED_44_a14f931657.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

