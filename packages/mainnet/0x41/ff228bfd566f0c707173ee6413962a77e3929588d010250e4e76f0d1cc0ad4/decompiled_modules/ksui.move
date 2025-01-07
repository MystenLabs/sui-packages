module 0x41ff228bfd566f0c707173ee6413962a77e3929588d010250e4e76f0d1cc0ad4::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 9, b"kSUI", b"Kriya Staked SUI", b"Sui LST with yields boosted by the Kriya ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/springsui/ksui.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

