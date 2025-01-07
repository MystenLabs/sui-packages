module 0x1b7bf32a4e438d593bb702e1e47f3ceed1a8ec83435d1b92c9939b60541f6238::swmc {
    struct SWMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWMC>(arg0, 6, b"SWMC", b"SUI WET MY CAT!", b"While buying some BLUB! this bastard wet my cat...it was not happy at all!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5652_e066ae5dea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

