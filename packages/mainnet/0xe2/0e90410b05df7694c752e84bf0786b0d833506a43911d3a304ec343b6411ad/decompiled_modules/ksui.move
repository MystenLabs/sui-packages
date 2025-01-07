module 0xe20e90410b05df7694c752e84bf0786b0d833506a43911d3a304ec343b6411ad::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 6, b"KSUI", b"King Sui", b"King Sui KING Of Chains Lets Make Greate Again Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_01_26_08_dbe52a6ed1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

