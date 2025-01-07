module 0x888c25dcbecbcc7aa5d8a843fe65d809c934e8f234a2116cbdb2c70867b3d2a1::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWN>(arg0, 6, b"CLOWN", b"CLOWN SUI", b"Clown is bonded ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004628_58273b021c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

