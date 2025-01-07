module 0x2af51e46719e0b75acd9d8a8ace35833a73834ef4bac6fd6a5942d1f7899d7b5::suipark {
    struct SUIPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARK>(arg0, 6, b"SUIPARK", b"Sui Park", x"467269656e646c7920666163657320657665727977686572652c2068756d626c6520666f6c6b7320776974686f75742074656d70746174696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5825662781410624436_d12e06e5b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

