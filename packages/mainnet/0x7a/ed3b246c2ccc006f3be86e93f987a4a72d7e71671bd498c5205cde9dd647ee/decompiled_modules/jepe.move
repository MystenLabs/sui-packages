module 0x7aed3b246c2ccc006f3be86e93f987a4a72d7e71671bd498c5205cde9dd647ee::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"JEPE", b"jepeonsui", b"the most memeable jellyfish on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003824028.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

