module 0x6372a4fd61c6cd6eb25edc49b36eda88cfd293a520055b56f9a4e7723a86746e::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"SPARK", b"Spark AI", x"54686520666972737420616c6c20696e204f6e65204149204167656e74202620496e73757265642046696e616e6369616c2041647669736f722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735944162671.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

