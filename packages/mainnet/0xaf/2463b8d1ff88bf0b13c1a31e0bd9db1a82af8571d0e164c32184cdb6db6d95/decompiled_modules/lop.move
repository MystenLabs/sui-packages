module 0xaf2463b8d1ff88bf0b13c1a31e0bd9db1a82af8571d0e164c32184cdb6db6d95::lop {
    struct LOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOP>(arg0, 9, b"LOP", b"lop", b"loplop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/28590111-8ffc-4d8a-b788-534daa15c426.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

