module 0xb912cd84cf600af757cca411c49fe86282a44389b89b01942b93a811ce9bce05::Drobin {
    struct DROBIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROBIN>(arg0, 9, b"DROB", b"Drobin", b"drobin is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/883aaee3-66e3-49f8-a8cb-6a0fd32007fd.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROBIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROBIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

