module 0x818bb6a2ffd0c0669121c01e78337f35a3c5d075cd8d434adf5909d174fff30c::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"DOUG", b"doug", b"international parcel service", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doug2_80df4faedb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

