module 0xaa0a57350d89ccd158aacc283236404150628a973317da9ae998de89d21654dc::NobleLuluCrown {
    struct NOBLELULUCROWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBLELULUCROWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBLELULUCROWN>(arg0, 0, b"COS", b"NobleLulu Crown", b"More shimmer, more patrons, more power! Oh, insatiable appetite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_NobleLulu_Crown.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBLELULUCROWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBLELULUCROWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

