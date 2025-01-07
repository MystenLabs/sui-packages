module 0x6b5a09c4e8978a81c67e3e5eb53f00b985ea0931249b2ab423d5d0b0329f139c::dogsock {
    struct DOGSOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSOCK>(arg0, 6, b"Dogsock", b"dog in a sock", b"dog in a mf sock ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6236_5293172c7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

