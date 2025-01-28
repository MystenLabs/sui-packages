module 0x34ddc1d4da1e0dbce6fa05545254ff5b1b0ba1cdb0250685ff55aacb3eac31ff::herd {
    struct HERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERD>(arg0, 9, b"Herd", b"CG Herd DAO", x"5468652043727970746f476f617420486572642044414f2061696d7320617420616371756972696e67204e46547320616e64205375692065636f73797374656d20636f696e7320746f20637265617465206120636f6d6d756e697479206f6620696e766573746f727320616e6420667269656e64732e20546f6765746865722077652077696c6c20616c6c2072697365e280a66261616168212121f09f9090", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/5734a5c0-ddb2-11ef-8055-0d7cc78361d5")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HERD>>(v1);
        0x2::coin::mint_and_transfer<HERD>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

