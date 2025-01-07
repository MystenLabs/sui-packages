module 0x62c96070a278f8b777329ee43447a3ca24915d4ad251474f458b9623cdc0abe8::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"SUIGULL", b"Suigull The Gull", b"Eating up all these other small fish memes on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_8_02_28_PM_aa91587fae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

