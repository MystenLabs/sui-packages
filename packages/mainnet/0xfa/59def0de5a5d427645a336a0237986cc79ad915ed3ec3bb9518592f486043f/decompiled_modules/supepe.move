module 0xfa59def0de5a5d427645a336a0237986cc79ad915ed3ec3bb9518592f486043f::supepe {
    struct SUPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPEPE>(arg0, 6, b"SUPEPE", b"Suicidal Pepe", b"PEPE the FROG on SUI that attracts serious investment due to our viral nature and it`s high potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_1ec6daf7d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

