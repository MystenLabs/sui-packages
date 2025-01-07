module 0xf061a4076bd2cee1386ee4a8e33868d6a2059130876ded519dedb48a61ee09b9::thui {
    struct THUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUI>(arg0, 6, b"THUI", b"Thui", b"cant thop wont thop thinking bout thui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thinking_bout_thui_6a73ed9d15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

