module 0x319c245d9945c16ae1c25fdc7c70998a78001a5e32e664264a28031751f4564f::titan {
    struct TITAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAN>(arg0, 9, b"TITAN", b"titan", b"titans ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/7ed0e1b7-da72-4776-8adc-ee8073ffa8c2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

