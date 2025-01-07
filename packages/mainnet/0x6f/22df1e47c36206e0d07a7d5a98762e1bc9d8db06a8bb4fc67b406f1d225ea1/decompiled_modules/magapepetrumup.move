module 0x6f22df1e47c36206e0d07a7d5a98762e1bc9d8db06a8bb4fc67b406f1d225ea1::magapepetrumup {
    struct MAGAPEPETRUMUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAPEPETRUMUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAPEPETRUMUP>(arg0, 6, b"Magapepetrumup", b"Maga pepe Trump", x"4d6167612070657065207472756d702077652074686f7567687420746f206c61756e636820697420666f722061206c617567682061732061206a6f6b65203a440a4c657473207365652069662077652063616e2073656e6420697420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241021_210943_681_df19d498f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAPEPETRUMUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAPEPETRUMUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

