module 0x171dbb39188f1e69e3c2ead84309f2795fa95090180110099e8d7ba2c6dc46d4::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAI>(arg0, 6, b"NAI", b"Neuro AI", b"Building smarter AI with neuromorphic computing and advanced training algorithms. Powered by $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cr8v_N_Jo_400x400_63187b5b3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

