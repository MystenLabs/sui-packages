module 0xf7fdbbde2f0c986d1dd7e9f148d6ed8b9b39280dd3dfd2013f39278718778819::birdeye {
    struct BIRDEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDEYE>(arg0, 6, b"Birdeye", b"Birdeye.so", b"the bird is watching the chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3ou_B_Ljvj_400x400_a51723eb7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

