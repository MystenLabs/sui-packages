module 0x7b2ee7dc1f4a1f487880f9cad30a1714c4d250bb5d2a9f620a3f57dfc2da6016::kxp {
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

