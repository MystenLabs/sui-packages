module 0x1b61b5156d51c533e12c13765e23aa83b78054f99fe947a3efeded834ff518f2::nenen {
    struct NENEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NENEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NENEN>(arg0, 6, b"NENEN", b"Cat Nenen", b"A nenen cat is where it wants to meet its mother and nurse all day long", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042456_894852acbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NENEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NENEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

