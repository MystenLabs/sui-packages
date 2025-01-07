module 0xb5966825a46914059fd7b606641b49f75803e91bfda4c715ec16773e1caa27e9::suipeipei {
    struct SUIPEIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEIPEI>(arg0, 6, b"SUIPEIPEI", b"SUI PEIPEI", b"PEIPEI HAS ARRIVED ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peipei_8e5536b491.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

