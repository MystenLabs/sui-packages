module 0x3cbef03344b6a59b862c5fab5a980a24c93f43a6f0252a2f242340361ee20531::kenzsui {
    struct KENZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENZSUI>(arg0, 6, b"KENZSUI", b"Kenzo", b"Kenzo the lion ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1200x801fffeeee_fe97e5c0e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

