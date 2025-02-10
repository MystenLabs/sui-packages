module 0xf0214ca7c4b040c8d839539ef91a027c8ed88e42ff182c465fab87b12785b98c::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"Suishi", b"SUISHI", b"The most delicious way to roll on #SUI Chain. Blue rice, big dreams, and endless vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B60_A4_D35_D2_FA_41_B8_BE_12_D32_AED_376620_e6c874956f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

