module 0x9c16961b34d19aeb7da802001677b0f71b632a1b7bdf1e93291d0379c751f3c::kbsui {
    struct KBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBSUI>(arg0, 6, b"KBSUI", b"KABOSUI", b"The Sui version of KABOSU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ET_0z4p2_I_400x400_4515756277.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

