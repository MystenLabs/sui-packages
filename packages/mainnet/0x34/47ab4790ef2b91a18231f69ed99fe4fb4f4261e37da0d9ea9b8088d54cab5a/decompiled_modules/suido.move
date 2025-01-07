module 0x3447ab4790ef2b91a18231f69ed99fe4fb4f4261e37da0d9ea9b8088d54cab5a::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"Suido woodo", b"Suidowoodo on the $SUI Chain woodo woodo woodo woodo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026604_686d5c7888.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

