module 0x70618693154e91da6a32afa331e275b4982952a94a4c8c1167ac6a91bb59eea0::krab {
    struct KRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAB>(arg0, 6, b"KRAB", b"Mr. Krabs", b"MOOOOOOONEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731087809534.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

