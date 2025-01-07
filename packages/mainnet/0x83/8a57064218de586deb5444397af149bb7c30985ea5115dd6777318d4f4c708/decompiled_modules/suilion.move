module 0x838a57064218de586deb5444397af149bb7c30985ea5115dd6777318d4f4c708::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"Suilion on SUI", x"636f6c6f6e79206f66207375696c696f6e732074616b696e67206f766572207375690a0a7377696d20686572653a2068747470733a2f2f742e6d652f7375696c696f6e6f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/alion_1173178f68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILION>>(v1);
    }

    // decompiled from Move bytecode v6
}

