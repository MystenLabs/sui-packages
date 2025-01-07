module 0x5d791cc84e354aff7bb56b6705fe96fb906d4cb9ac2e0cab3ead388ae8578923::rainy {
    struct RAINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAINY>(arg0, 6, b"Rainy", b"Rainy on Sui", b"X : https://x.com/RainyOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ek_VKY_Vnk_400x400_0a2a41b422.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

