module 0x51b87bb3511e0f8a0f3b7d56033b6167cd457330e6d719974d7c3985ddf21ce1::insuilin {
    struct INSUILIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSUILIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSUILIN>(arg0, 6, b"INSUILIN", b"INSUILIN PUMP", b"That's the real PUMP. Not your typical crypto fakes. RUG = instant patient death, so no rugs today. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/insuilin_f6ec610a29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSUILIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSUILIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

