module 0x56c8bac01d3324e671d95c06dee9c954ac36a01d726ddc0d3e5c9360bc02eb50::snmi {
    struct SNMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNMI>(arg0, 6, b"SNMI", b"SUINAMI", b"$NAMI is here to ride the waves ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINAMI_a6003982a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

