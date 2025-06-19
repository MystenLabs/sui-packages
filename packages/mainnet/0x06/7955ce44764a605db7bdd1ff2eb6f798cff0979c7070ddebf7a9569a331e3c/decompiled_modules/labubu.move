module 0x67955ce44764a605db7bdd1ff2eb6f798cff0979c7070ddebf7a9569a331e3c::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"Labubu", b"labubu", b"Labubu became famous and popular because Lisa from Blackpink post she had been collecting them and found them cute. This sparked a trend among people to collect them, further fueling the craze.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750304558529.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

