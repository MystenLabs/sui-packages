module 0xeb19e7be702e4563404235b9c5898820941d5f2a2b73318fd5c08caf36e8425c::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"First Mario On Sui", b"Mario's journey to conquer Sui begins. With the mission to become the top meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/future_ff08272a32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

