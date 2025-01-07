module 0x21e65e41e3bdf1c906497b9abbef391dedb5cfe9d2a7f880adb3942f714925fa::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 6, b"SPAM", b"SPAM SUI", x"205350414d205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Ee5v7_DZ_400x400_a4f0015965.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

