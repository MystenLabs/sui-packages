module 0xabd576abdf677aa76521bc92c1de4717fee0874e593fc8932706d458f65f7e8d::dyful {
    struct DYFUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYFUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYFUL>(arg0, 9, b"DYFUL", b"sykijdtyukl", b"kyuik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/499c0dcc7b70e4c7f67eaeff3e49599dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYFUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYFUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

