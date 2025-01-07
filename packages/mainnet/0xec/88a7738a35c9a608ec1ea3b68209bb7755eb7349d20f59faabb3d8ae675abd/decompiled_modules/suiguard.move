module 0xec88a7738a35c9a608ec1ea3b68209bb7755eb7349d20f59faabb3d8ae675abd::suiguard {
    struct SUIGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUARD>(arg0, 6, b"SUIGUARD", b"SUIGUARD WALLET", b"Empower your journey in the decentralized world with Sui Guard Walletwhere security meets simplicity, enabling you to explore dApps effortlessly while keeping your assets safe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3951_7ea3a33bcf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

