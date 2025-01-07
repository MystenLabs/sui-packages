module 0x54ce214b473636424fb9daf55d5cb14e7b8b4512785ed527435c0d980bd68aac::bluel {
    struct BLUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEL>(arg0, 6, b"BlueL", b"Blue Eyed Lemur", b"A blue eyed Lemur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_072013_162fbd0f5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

