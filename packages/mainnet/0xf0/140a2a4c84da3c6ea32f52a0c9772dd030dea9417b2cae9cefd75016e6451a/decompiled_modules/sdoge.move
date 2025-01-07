module 0xf0140a2a4c84da3c6ea32f52a0c9772dd030dea9417b2cae9cefd75016e6451a::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"SDOGE", b"DOGE", b"Will people like this cool dog? No doubt we'll send him to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012764_6b9541fab9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

