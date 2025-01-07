module 0x31d1364f77055c5a4a95a6ecdfe68e1545089bbe93f5d73b57d825ed53fde845::suiguys {
    struct SUIGUYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUYS>(arg0, 6, b"SUIGUYS", b"SUIGUY", b"SUI GUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732317517167.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGUYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

