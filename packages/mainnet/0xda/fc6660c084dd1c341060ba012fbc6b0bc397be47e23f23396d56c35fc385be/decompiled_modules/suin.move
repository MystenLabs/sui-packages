module 0xdafc6660c084dd1c341060ba012fbc6b0bc397be47e23f23396d56c35fc385be::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"SuiNeiro", b"This is the official Suineiro, ran by THE DEN cabal, Tg only no X yet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6827_3ccfdc1e3e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

