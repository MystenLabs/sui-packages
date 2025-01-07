module 0xffecda8530704a4d5e51ffc053f5e34612be2a951df78c1ae32d0bf42c5474fa::smf {
    struct SMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMF>(arg0, 6, b"Smf", b"Suimurfs", b"Memefuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042657_3a6ff4073a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

