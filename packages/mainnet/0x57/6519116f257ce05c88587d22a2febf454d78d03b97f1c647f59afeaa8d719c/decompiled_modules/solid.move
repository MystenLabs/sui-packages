module 0x576519116f257ce05c88587d22a2febf454d78d03b97f1c647f59afeaa8d719c::solid {
    struct SOLID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLID>(arg0, 9, b"SOLID", b"STAY SOLID", b"NEVER BROKE AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/solid-vector-text-style-effect_210126-535.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOLID>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLID>>(v1);
    }

    // decompiled from Move bytecode v6
}

