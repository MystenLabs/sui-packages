module 0x76b6b216d52732526df6e89ce16b145e7d125eca909c4537cedefd15237e566f::suibit {
    struct SUIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIT>(arg0, 6, b"SUIBIT", b"The suibit", b"Meet SUIBIT, a memecoin with the best ticker you'll ever see on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053668_db2385e9dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

