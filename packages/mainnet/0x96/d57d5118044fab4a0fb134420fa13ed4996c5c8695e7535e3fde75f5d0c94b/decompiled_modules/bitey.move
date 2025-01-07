module 0x96d57d5118044fab4a0fb134420fa13ed4996c5c8695e7535e3fde75f5d0c94b::bitey {
    struct BITEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITEY>(arg0, 6, b"BITEY", b"Bitey", b"Bite the hand that feed you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11989911854_8a3f316e47_o_jpg_f969f70e2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

