module 0x1615491e6b821bd68add839f865201b851cc21fe26c1fef6dc3d3983b8cca10b::pslfg {
    struct PSLFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSLFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSLFG>(arg0, 6, b"PSLFG", b"Palestinian frog", b"The valiant Palestinian frog: A brave frog carrying the Palestinian flag, leaping over walls and obstacles, symbolizing Palestinian resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001236427_99aa9feccc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSLFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSLFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

