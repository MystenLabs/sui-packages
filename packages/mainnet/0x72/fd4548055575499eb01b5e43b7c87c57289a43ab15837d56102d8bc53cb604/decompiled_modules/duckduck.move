module 0x72fd4548055575499eb01b5e43b7c87c57289a43ab15837d56102d8bc53cb604::duckduck {
    struct DUCKDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKDUCK>(arg0, 9, b"DUCK", b"duckduck", b"duckfrog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/c6c42403-5dd5-41b1-81c5-88712c33dca9.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

