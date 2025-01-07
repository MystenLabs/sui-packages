module 0x5fa5c63f6f2870c7a555db508995869780beabd5b5964c7212a41ce2c35dd65c::berries {
    struct BERRIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERRIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERRIES>(arg0, 6, b"Berries", b"Shanks Akagami ", b"RedHaired Shanks, commonly known as just Red Hair, is the chief of the Red Hair Pirates and one of the Four Emperors that rule over the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958558060.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERRIES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERRIES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

