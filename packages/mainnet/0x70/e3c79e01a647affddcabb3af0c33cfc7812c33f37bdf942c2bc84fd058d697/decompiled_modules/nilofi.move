module 0x70e3c79e01a647affddcabb3af0c33cfc7812c33f37bdf942c2bc84fd058d697::nilofi {
    struct NILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILOFI>(arg0, 6, b"NiLofi", b"Nigga Lofi", b"Nigga-Yeti", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/niga_lofi_profil_150c3c84b0.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

