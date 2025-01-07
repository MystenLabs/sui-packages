module 0xb64d57bcfadff2d18a3aa270bb7d43f2636089eaf5ddd15bc5d554751f4c1888::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 0, b"POO", b"POO", b"Utility token of the Stashdrop ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stashdrop.org/assets/tokens/poo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v2, @0xd27cc4a3a53b74e3abebb100949839d37d21264ad7616f7653019803fc43a046);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POO>>(v1);
    }

    // decompiled from Move bytecode v6
}

