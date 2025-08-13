module 0x14e01d8cd0fdad548f39db9e9c9f5dce0ea44f9a9b5b3462ff30f10d1a99eaf7::Big_Mikey {
    struct BIG_MIKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG_MIKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG_MIKEY>(arg0, 9, b"BIG", b"Big Mikey", b"biggy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/cc5ea369-6a3b-4bd2-a183-9778906bfe3b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG_MIKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG_MIKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

