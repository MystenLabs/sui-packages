module 0x161aaf29032169cc31fbf92b65580ff69cb737587ba96a7984445fdbaa6a46a0::tatataat {
    struct TATATAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATATAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATATAAT>(arg0, 6, b"TATATAAT", b"TATATATA", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puffer_bc5acb2633.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATATAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATATAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

