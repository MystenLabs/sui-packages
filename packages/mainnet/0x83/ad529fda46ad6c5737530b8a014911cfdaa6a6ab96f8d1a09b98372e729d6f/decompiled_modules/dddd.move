module 0x83ad529fda46ad6c5737530b8a014911cfdaa6a6ab96f8d1a09b98372e729d6f::dddd {
    struct DDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DDDD>(arg0, 6, b"DDDD", b"ksodf", b"ada", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"undefined")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDDD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

