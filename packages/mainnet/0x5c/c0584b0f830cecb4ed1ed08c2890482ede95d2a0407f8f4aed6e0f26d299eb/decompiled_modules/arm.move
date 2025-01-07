module 0x5cc0584b0f830cecb4ed1ed08c2890482ede95d2a0407f8f4aed6e0f26d299eb::arm {
    struct ARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARM>(arg0, 9, b"ARM", b"ARMANY", b"Armany Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

