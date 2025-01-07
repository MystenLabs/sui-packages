module 0x9d19780624536e719eeb78fa846fd97827d804e64e970010f182381b6f246170::droke {
    struct DROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROKE>(arg0, 6, b"DROKE", b"DROKESUI", b"DROKE is a snooper kool singer from canuda who wraps and sings. As a den on stake his mishun is 2unify da cummunity 2get their first max wynn. We are bringing 2gether all da droke memes to celebrate dis generason music icon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_19_48_55_d622d0b2fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

