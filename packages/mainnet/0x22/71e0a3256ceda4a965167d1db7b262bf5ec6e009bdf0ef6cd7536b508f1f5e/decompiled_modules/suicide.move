module 0x2271e0a3256ceda4a965167d1db7b262bf5ec6e009bdf0ef6cd7536b508f1f5e::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"SUICIDAL ATTACK", b"SUICIDE FOR EYES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3877_2a85086c76.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

