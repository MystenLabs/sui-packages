module 0x338ddc7a1862208a64896b32ee79569d24f0ea425401517b0d6eba0373c2252::dimple {
    struct DIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIMPLE>(arg0, 6, b"DIMPLE", b"DIMPLE", b"Road to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/VsrWM1GaVIsAAAAC/darla-dimple-cats-dont-dance.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIMPLE>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIMPLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

