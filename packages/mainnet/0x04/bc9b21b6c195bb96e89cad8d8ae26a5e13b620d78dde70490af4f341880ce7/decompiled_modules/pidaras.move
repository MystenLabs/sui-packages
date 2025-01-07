module 0x4bc9b21b6c195bb96e89cad8d8ae26a5e13b620d78dde70490af4f341880ce7::pidaras {
    struct PIDARAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIDARAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIDARAS>(arg0, 9, b"PIDARAS", b"PIDARAS", b"PIDARAS YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/wkK5-InZM2MAAAAe/%D0%B5%D0%B1%D0%B0%D1%82%D1%8C-%D0%BA%D0%BE%D1%82.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIDARAS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIDARAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIDARAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

