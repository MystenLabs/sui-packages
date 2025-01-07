module 0x8bce6e9596535cb049b3d6095ecc903e52db961ff2670fbea5c4b7e577f3104b::epep {
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

