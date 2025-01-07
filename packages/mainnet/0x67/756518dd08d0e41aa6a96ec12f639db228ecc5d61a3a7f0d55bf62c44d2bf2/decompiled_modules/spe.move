module 0x67756518dd08d0e41aa6a96ec12f639db228ecc5d61a3a7f0d55bf62c44d2bf2::spe {
    struct SPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPE>(arg0, 6, b"SPe", b"Supee", b"Sui x Pepe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734702788839.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

