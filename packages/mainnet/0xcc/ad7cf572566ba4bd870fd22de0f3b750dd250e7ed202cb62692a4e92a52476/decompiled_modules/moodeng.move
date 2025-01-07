module 0xccad7cf572566ba4bd870fd22de0f3b750dd250e7ed202cb62692a4e92a52476::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"moodeng", x"756e626f7468657265642e206d6f6973747572697a65642e2068617070792e20696e206d79206c616e652e20666f63757365642e20666c6f7572697368696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xjahj8_W0_AA_289_T_ba05e83dbe.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

