module 0x9fbd35d71c880580e548fac3bb07b26a5d3b6d04b8e5356375f7933e9fcb10e9::dengy {
    struct DENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGY>(arg0, 9, b"DENGY", b"DENGY", b"DENGY DENGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DENGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

