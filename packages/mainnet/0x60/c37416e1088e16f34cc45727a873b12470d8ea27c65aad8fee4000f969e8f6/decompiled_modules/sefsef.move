module 0x60c37416e1088e16f34cc45727a873b12470d8ea27c65aad8fee4000f969e8f6::sefsef {
    struct SEFSEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEFSEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEFSEF>(arg0, 6, b"SEFSEF", b"sfsFesee", b"SFsEfSEfeesfeSFSEFf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_32_3aa7a3f03a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEFSEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEFSEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

