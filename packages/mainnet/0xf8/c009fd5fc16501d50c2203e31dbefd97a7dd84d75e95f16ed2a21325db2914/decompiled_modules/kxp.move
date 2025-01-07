module 0xf8c009fd5fc16501d50c2203e31dbefd97a7dd84d75e95f16ed2a21325db2914::kxp {
    struct KXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KXP>(arg0, 6, b"KXP", b"kamalaxtrump", b"kamala vs trump new token on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1_932507b620.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

