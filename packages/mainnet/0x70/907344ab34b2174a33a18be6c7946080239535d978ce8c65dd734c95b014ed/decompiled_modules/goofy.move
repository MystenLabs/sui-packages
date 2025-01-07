module 0x70907344ab34b2174a33a18be6c7946080239535d978ce8c65dd734c95b014ed::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFY", b"Captain GOOFY", x"546865206772656174657374206669736865726d616e206f6620746865200a407375696e6574776f726b0a206f6365616e2072647920746f2024474f4f462020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Q_Ajk_NBG_400x400_15db4ae98f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

