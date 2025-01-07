module 0x8464b49ed960c9a8530259248f9c2ad6c1e66acc5fb0ded0b5941dba872cc812::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"BBCC", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240927153427_222ab97ad5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

