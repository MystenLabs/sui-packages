module 0xdac679bc700135e7235336d57a4dc7f2a69002e09257e58be4f18fad65ef13ec::totorro {
    struct TOTORRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTORRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTORRO>(arg0, 9, b"TORT", b"totorro", b"fat and cute. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/f1b8e495-64e2-4173-b24e-ed0b9ae16677.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOTORRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTORRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

