module 0xfc9377c347403891fd244e962587b827b47af30d2040696644b4a042359f59c0::jpfr {
    struct JPFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPFR>(arg0, 6, b"JPFR", b"JUMPY FROG", b"Leaping through the meme pond, Jumpy Frog is all about fast and funny gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_053108563_aa4c16ba16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

