module 0xa09f122c12c8b2c99ae59d039ba1388a3320ae94ffa57a45d563aa60213d569e::soup {
    struct SOUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUP>(arg0, 6, b"SOUP", b"SOUP ON SUI", b"SOUP of the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731168607853.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

