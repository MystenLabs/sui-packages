module 0x7e1196d3c3c17fdcef4c9e1be8dc52e0108f3877f7fb26459227d3ec0ed3341d::tone {
    struct TONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONE>(arg0, 7, b"Tone", b"Test1", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONE>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONE>>(v2, @0x7cee6c0695ea5f18b441028b1505db16d8be50b89c390806c11f55d98966530c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

