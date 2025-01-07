module 0xccbef0edd4db3dae3ce964bb16d5e90e3e603903823bd0a440f1880cb7d7b0ae::epep {
    struct EPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPEP>(arg0, 6, b"EPEP", b"PEPE backwards", b"We are the opposite of PEPE, EPEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/epep_c080de6327.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

