module 0x6f45f3e47be57f10d0cbab4aa8194db10bf86e8250e505585bf895151d4a6824::dounmontana {
    struct DOUNMONTANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUNMONTANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUNMONTANA>(arg0, 6, b"DOUNMONTANA", b"DOUNMONTANA SUI", b"donymontana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/about_adde1d52be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUNMONTANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUNMONTANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

