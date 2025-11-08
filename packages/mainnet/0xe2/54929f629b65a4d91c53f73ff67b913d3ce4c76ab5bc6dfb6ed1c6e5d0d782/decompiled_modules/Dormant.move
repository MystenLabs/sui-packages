module 0xe254929f629b65a4d91c53f73ff67b913d3ce4c76ab5bc6dfb6ed1c6e5d0d782::Dormant {
    struct DORMANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORMANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORMANT>(arg0, 9, b"DORMANT", b"Dormant", b"mask", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1868486903353520128/tGr2G4o5_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORMANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORMANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

