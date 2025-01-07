module 0x99e507d0fbc51dae281e24a27fa123728d780aa6d74b2a22d5c528a9938bdd27::titis {
    struct TITIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITIS>(arg0, 6, b"TITIS", b"SuiTits", b"Sui titis ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5801_de133461d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

