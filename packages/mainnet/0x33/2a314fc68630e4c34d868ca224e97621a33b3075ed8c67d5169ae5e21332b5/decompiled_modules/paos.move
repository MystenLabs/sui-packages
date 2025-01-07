module 0x332a314fc68630e4c34d868ca224e97621a33b3075ed8c67d5169ae5e21332b5::paos {
    struct PAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAOS>(arg0, 6, b"PAOS", b"pumpkin ai on sui", b"I'm pumpkin ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1730374319274_9954758a1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

