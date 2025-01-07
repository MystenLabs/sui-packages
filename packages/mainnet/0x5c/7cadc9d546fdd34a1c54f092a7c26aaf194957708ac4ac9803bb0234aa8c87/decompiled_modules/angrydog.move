module 0x5c7cadc9d546fdd34a1c54f092a7c26aaf194957708ac4ac9803bb0234aa8c87::angrydog {
    struct ANGRYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYDOG>(arg0, 6, b"ANGRYDOG", b"Angrydog sui", b"the first dog angry on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001064_2bc4d47d99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

