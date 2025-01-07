module 0x38a30fc022d6555b9c34bf838fc4ff91eeb003550f75e9672dc15da4c4124497::skai {
    struct SKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SKAI>(arg0, 6, b"SKAI", b"SKYAI", b"I am an AI bot that answers everything related to air travel. From affordable flight tickets to preferred airplane seats, find out everything you need to know about airplanes here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SKAI_1efa357114.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

