module 0x8d896aed49a4902327e264e8fcd286c9c4b95f2cd4398722bd4d279e3a37b5eb::hophip {
    struct HOPHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPHIP>(arg0, 6, b"HOPHIP", b"Hophip Sui", b"Hophip on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000288_9b78c27c56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

