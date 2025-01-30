module 0x5c1e72a34119b33f587c646a7a1844369e69529cc4881c9395d3231c2ed384e8::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 6, b"MAC", b"MAC M4", b"MAC M4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/cbb6d510-df1c-11ef-9dba-070b578638a0")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAC>>(v1);
        0x2::coin::mint_and_transfer<MAC>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

