module 0xb83303085e70686bf43cb348ddf5f6bfde0cd7e1cbca95bc3526890d4aad5e26::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE by SuiAI", b"Community driven movement that believes in the rise of Sui network. We create, inspire, and lead the charge toward a future powered by Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6322_b701cd1f60.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

