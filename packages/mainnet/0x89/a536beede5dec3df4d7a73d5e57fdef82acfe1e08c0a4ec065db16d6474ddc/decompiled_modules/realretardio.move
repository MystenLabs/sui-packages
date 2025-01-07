module 0x89a536beede5dec3df4d7a73d5e57fdef82acfe1e08c0a4ec065db16d6474ddc::realretardio {
    struct REALRETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALRETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALRETARDIO>(arg0, 6, b"RealRetardio", b"Just A Chill Real Retardio", b"Real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7200_819417c3e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALRETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REALRETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

