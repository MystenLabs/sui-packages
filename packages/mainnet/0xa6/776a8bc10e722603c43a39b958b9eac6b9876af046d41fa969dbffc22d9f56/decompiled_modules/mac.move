module 0xa6776a8bc10e722603c43a39b958b9eac6b9876af046d41fa969dbffc22d9f56::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 6, b"MAC", b"MAC M3", b"MAC M3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/01fd2340-ded2-11ef-9dba-070b578638a0")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAC>>(v1);
        0x2::coin::mint_and_transfer<MAC>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

