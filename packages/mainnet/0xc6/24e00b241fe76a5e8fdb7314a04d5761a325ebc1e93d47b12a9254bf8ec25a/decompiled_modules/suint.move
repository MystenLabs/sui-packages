module 0xc624e00b241fe76a5e8fdb7314a04d5761a325ebc1e93d47b12a9254bf8ec25a::suint {
    struct SUINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINT>(arg0, 6, b"Suint", b"Suint on Sui", x"4c457473205375696e7420616c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_15_22_33_21_78a0ef9fc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

