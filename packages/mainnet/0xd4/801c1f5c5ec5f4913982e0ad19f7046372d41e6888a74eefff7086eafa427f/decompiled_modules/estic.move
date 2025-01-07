module 0xd4801c1f5c5ec5f4913982e0ad19f7046372d41e6888a74eefff7086eafa427f::estic {
    struct ESTIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTIC>(arg0, 6, b"ESTIC", b"Esti Cat", b"funny cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015292_fbb2e70f34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESTIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

