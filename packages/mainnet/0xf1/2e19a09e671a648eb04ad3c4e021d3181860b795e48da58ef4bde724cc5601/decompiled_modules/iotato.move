module 0xf12e19a09e671a648eb04ad3c4e021d3181860b795e48da58ef4bde724cc5601::iotato {
    struct IOTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOTATO>(arg0, 6, b"IOTATO", b"Sui Iotato", b"IOTATO - fresh  from the soil  of IOTA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012363_c9b2377d40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

