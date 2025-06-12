module 0x8f0ae0636bca3ffe9af8feeb75df3a50edc178fd14bd871470c4433f158965fe::anotherone {
    struct ANOTHERONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANOTHERONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANOTHERONE>(arg0, 9, b"AN1", b"anotherone", x"416e6f74686572206f6e6520666f722074686520636869636b656e730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/54aa4ffd-be22-4984-be8c-fa908d197188.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANOTHERONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANOTHERONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

