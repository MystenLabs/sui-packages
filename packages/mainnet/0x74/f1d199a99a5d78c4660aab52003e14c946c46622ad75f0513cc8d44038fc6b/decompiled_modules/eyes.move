module 0x74f1d199a99a5d78c4660aab52003e14c946c46622ad75f0513cc8d44038fc6b::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYES>(arg0, 9, b"EYES", b"eyes", b"looking into my eyes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/b04494d5-70ab-4534-874c-0d3f74a94326.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

