module 0x7f51a1d26075507824cdbf976bd7305337d1b599a454bca33a6a6396d87a4776::buddha {
    struct BUDDHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDHA>(arg0, 6, b"BUDDHA", b"BUDDHA Token", b"Step into the mystical realms with Buddha Token, a sacred conduit on Solana's ethereal path. Join our quest for prosperity and enlightenment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T1w_VKA_Wz_400x400_91e7b2c172.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

