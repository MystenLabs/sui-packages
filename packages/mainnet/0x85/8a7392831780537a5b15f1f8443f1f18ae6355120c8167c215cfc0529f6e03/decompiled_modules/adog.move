module 0x858a7392831780537a5b15f1f8443f1f18ae6355120c8167c215cfc0529f6e03::adog {
    struct ADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOG>(arg0, 6, b"ADOG", b"AKITA", b"Fulfillment Summit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0b80756ae7d18ac9468b8980b946402e_4b273ef4e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

