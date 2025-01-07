module 0x6d6f1111c19bcbb86110ff785712cfe5261f9227d22c38254c1feb0d1e41c0db::mono {
    struct MONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONO>(arg0, 6, b"MONO", b"Monopoly", b"$MONO token rockets towards viral memecoin status, outpacing Doge, Shiba Inu, Pepe, Bonk, and others with staggering profits! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037496_3cf6d4d96e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

