module 0x276b77c6420ea04740bc2053b4c81ff2cd2035fd53ba5bec68760108a4f6e0f7::snurky {
    struct SNURKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNURKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNURKY>(arg0, 6, b"Snurky", b"Snurky Sui", b"Snurky - is a vegan shark who is against eating meat, enjoys surfing and coffee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003765_d607d1e272.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNURKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNURKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

