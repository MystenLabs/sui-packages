module 0x57c1caabf8d1c8d87a131069ad97d752b4382806290ff9df914f3a932a0ba001::tdy {
    struct TDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDY>(arg0, 6, b"TDY", b"Teddy", x"4e6577205374656164792054656464792077686f20646973200a40737465616479746564647973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ET_De_Gn2_K_400x400_a6a232b673.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

