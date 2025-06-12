module 0xb05f404999ba1d9f82d55472cac4791d1a95787cdddbfea545df06f13e58dca3::rabbit_mod {
    struct RABBIT_MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT_MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT_MOD>(arg0, 9, b"rabbit", b"rabbit mod", b"rabbit disguised as a duck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/0de89e0a-a12f-4982-93dc-db26e2c7c08d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT_MOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT_MOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

