module 0x58e5054e9753a86a201c2a0f007617ad5433f60fcf9532b30c34b2517cabb45d::blustl {
    struct BLUSTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUSTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUSTL>(arg0, 6, b"BLUSTL", b"Bluesteel", b"Bluesteel on SUI is really, really, really ridiculously good looking!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blustl_pfp1_dca430ea50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUSTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUSTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

