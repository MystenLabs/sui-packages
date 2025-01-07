module 0x52f8fd984047c16ca32d37128d52b5383d9e09da81dd4e29b0466f99453f67d0::shibas {
    struct SHIBAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAS>(arg0, 6, b"SHIBAS", b"ShibaSea", b"A wonderful dog in the Shiba family. Ready for a fun walk?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IR_9_Ccbbq_400x400_0d7bfb4908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

