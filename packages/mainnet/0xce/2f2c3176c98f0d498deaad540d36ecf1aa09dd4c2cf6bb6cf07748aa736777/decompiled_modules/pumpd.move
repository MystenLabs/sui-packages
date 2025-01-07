module 0xce2f2c3176c98f0d498deaad540d36ecf1aa09dd4c2cf6bb6cf07748aa736777::pumpd {
    struct PUMPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPD>(arg0, 6, b"PumpD", b"PumpDog", b"Go up I need to feed my family ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AF_67_D042_2_F9_D_4057_B256_F091227_FDBBC_ff0eaeecb9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

