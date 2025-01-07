module 0x4f08c38841b8a8efd2644bfe33cde3a8ed8ffbfc3c2de0ba412d14906073c11e::mood {
    struct MOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOD>(arg0, 6, b"MOOD", b"MOO DENG SUI", b"This is Moo Deng Baby Hippo on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moo_deng_0180a44b9b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

