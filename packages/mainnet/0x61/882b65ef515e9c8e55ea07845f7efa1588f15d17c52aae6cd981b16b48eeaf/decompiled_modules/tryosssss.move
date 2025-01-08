module 0x61882b65ef515e9c8e55ea07845f7efa1588f15d17c52aae6cd981b16b48eeaf::tryosssss {
    struct TRYOSSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYOSSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYOSSSSS>(arg0, 9, b"TRYOSSSSS", b"TRYOSSSS", b"SDs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYOSSSSS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYOSSSSS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYOSSSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

