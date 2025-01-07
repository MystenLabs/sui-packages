module 0x254906c87e3cf5148d92abd202d44efccbadeac0591f463ce14fd3927487567e::PLANT {
    struct PLANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANT>(arg0, 6, b"PLANT", b"PLANT", b"123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qme8Wn2yEZEsBDTSA2aAomauiPkJby6wFGrsgD4SYkEEGG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

