module 0xc8d3693254a8052b41daeba87070ff1ce7b9b90579b60e3b18e477ad2d1f4811::bison {
    struct BISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISON>(arg0, 6, b"BISON", b"Bison", b"Buy Bison wait on bluemove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009752_be9fe96ddf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISON>>(v1);
    }

    // decompiled from Move bytecode v6
}

