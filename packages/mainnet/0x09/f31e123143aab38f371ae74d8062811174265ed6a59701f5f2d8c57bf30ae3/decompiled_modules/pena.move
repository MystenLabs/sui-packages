module 0x9f31e123143aab38f371ae74d8062811174265ed6a59701f5f2d8c57bf30ae3::pena {
    struct PENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENA>(arg0, 6, b"PENA", b"PITZOS", b"feliz jueves pena , el menu de hoy son: besitos ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg3bi2_WUAQK_Pnd_e312910ad2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

