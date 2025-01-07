module 0xd7bba2f1c978de30d4924afb74618a84c78841a3acb8e2c6a63db457382e116c::hachico {
    struct HACHICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHICO>(arg0, 6, b"HACHICO", b"HACHICO ON SUI", b" Hachiko Waits by Lesla Newman is a children's book about the loyal Akita, Hachiko, told through the eyes of a boy named Kentaro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_21_50_49_744c5174a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHICO>>(v1);
    }

    // decompiled from Move bytecode v6
}

