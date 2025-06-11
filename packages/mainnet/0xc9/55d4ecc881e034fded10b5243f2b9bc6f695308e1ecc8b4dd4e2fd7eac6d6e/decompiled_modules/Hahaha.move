module 0xc955d4ecc881e034fded10b5243f2b9bc6f695308e1ecc8b4dd4e2fd7eac6d6e::Hahaha {
    struct HAHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHAHA>(arg0, 9, b"haha", b"Hahaha", b"hahahahahahah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/65c2f3d1-fe7a-4edb-aabf-f6aa313db32d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHAHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHAHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

