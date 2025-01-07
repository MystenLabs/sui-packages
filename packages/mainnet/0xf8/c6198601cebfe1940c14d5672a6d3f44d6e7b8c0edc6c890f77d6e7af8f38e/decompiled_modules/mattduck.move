module 0xf8c6198601cebfe1940c14d5672a6d3f44d6e7b8c0edc6c890f77d6e7af8f38e::mattduck {
    struct MATTDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATTDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATTDUCK>(arg0, 6, b"Mattduck", b"Matt duck", b"Rendezvous on the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_125456_aafbb089f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATTDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATTDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

