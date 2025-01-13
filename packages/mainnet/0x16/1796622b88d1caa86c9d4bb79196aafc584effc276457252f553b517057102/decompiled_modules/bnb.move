module 0x161796622b88d1caa86c9d4bb79196aafc584effc276457252f553b517057102::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"BNB token", b"sfs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/0c7ddb4e-a627-4836-b22a-44fd1e7025b4.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

