module 0x4165ac16fcba53a1da394ed8731e9b2f86f52cd3cdbac3f889fddc216c00d9f9::deployiq {
    struct DEPLOYIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPLOYIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPLOYIQ>(arg0, 6, b"DEPLOYIQ", b"DeployIQ", b" An ultimate deployer platform that will make it easier for traders and developers to carry out their activities with just one platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_042937_838_10f13f3403.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPLOYIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEPLOYIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

