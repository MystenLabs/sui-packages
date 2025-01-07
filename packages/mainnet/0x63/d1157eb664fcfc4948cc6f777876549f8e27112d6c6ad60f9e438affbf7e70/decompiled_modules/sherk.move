module 0x63d1157eb664fcfc4948cc6f777876549f8e27112d6c6ad60f9e438affbf7e70::sherk {
    struct SHERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHERK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERK>(arg0, 6, b"SHERK", b"Shark or Shrek", b"Some may call me Shrek, some may call me Shark but im  the one the only SHERK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_25_15_56_19_3b82f0b9b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHERK>>(v1);
    }

    // decompiled from Move bytecode v6
}

