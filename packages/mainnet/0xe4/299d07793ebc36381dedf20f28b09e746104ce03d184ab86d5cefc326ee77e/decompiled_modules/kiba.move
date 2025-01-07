module 0xe4299d07793ebc36381dedf20f28b09e746104ce03d184ab86d5cefc326ee77e::kiba {
    struct KIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBA>(arg0, 6, b"KIBA", b"SuiKiba On Sui", b"Official $KIBA dog on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001500_0309cde55f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

