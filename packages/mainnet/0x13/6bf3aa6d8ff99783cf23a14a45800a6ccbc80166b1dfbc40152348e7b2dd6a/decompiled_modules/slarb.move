module 0x136bf3aa6d8ff99783cf23a14a45800a6ccbc80166b1dfbc40152348e7b2dd6a::slarb {
    struct SLARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLARB>(arg0, 6, b"SLARB", b"Sui Fish", b"The cutest fish on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/slarbfriend_f222cd009c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLARB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLARB>>(v1);
    }

    // decompiled from Move bytecode v6
}

