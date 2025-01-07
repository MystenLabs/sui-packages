module 0x53d7a163854f5e3b574f2b32fab7989c226a22381e970a3eb34366ce5066259e::magas {
    struct MAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAS>(arg0, 6, b"MAGAS", b"MAGAS on SUI", b"Make America Great Again on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N8_ZHM_8dp_400x400_98e304bff1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

