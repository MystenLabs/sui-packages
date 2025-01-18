module 0x7451fc914e4467694c891ee20ed9e169fdfb397572979e0de5aef656eda8e32c::sadjoe {
    struct SADJOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADJOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADJOE>(arg0, 6, b"SADJOE", b"Sad Joe Biden", b"It's all over for sleepy Joe Biden, and he's very sad about it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_23_7f2f969b88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADJOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADJOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

