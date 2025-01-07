module 0x654c2108045d056f2adacc18e29758f2a93524e5dfbac300918a0c57cf381cb8::sudog {
    struct SUDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOG>(arg0, 6, b"SuDoG", b"SuiDog", b"Spike frend Tom and Jerry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spike_fdffc6067f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

