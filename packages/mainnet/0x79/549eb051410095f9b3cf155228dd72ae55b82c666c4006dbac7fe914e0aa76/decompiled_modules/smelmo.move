module 0x79549eb051410095f9b3cf155228dd72ae55b82c666c4006dbac7fe914e0aa76::smelmo {
    struct SMELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMELMO>(arg0, 6, b"SMELMO", b"ELMO ON DRUGS", b"elmo on drugs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elmo_doing_drugs_2c92b4c8e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMELMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

