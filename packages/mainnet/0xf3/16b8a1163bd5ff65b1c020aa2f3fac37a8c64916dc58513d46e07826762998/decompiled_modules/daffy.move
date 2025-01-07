module 0xf316b8a1163bd5ff65b1c020aa2f3fac37a8c64916dc58513d46e07826762998::daffy {
    struct DAFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAFFY>(arg0, 6, b"DAFFY", b"Daffy On SUI", b"Set a reminder for my upcoming Space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_R4_BO_7d_N_400x400_c845f9f443.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

