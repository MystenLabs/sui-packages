module 0xc981e38929c317c19a1eaa9d0497070eab9bb978e20779ce1563a41f17c2ec75::bertie {
    struct BERTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERTIE>(arg0, 6, b"BERTIE", b"Bertie on Sui", b"The fastest turtle in the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zu_CT_Na_Wc_A_Ug_SB_9_9b69726455.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

