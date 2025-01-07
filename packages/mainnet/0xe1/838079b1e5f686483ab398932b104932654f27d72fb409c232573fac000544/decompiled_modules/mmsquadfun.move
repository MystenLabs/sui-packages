module 0xe1838079b1e5f686483ab398932b104932654f27d72fb409c232573fac000544::mmsquadfun {
    struct MMSQUADFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMSQUADFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MMSQUADFUN>(arg0, 6, b"MMSQUADFUN", b"MMsquad.fun", b"men just to earn a living", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SQUAD_4691cbc9d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMSQUADFUN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMSQUADFUN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

