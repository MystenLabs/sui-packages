module 0x97bb14ff0a4d843b6b6a92dbe3fdeb48f291dc09e6b461eae4cda95b9d30b83d::pansui {
    struct PANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANSUI>(arg0, 6, b"PANSUI", b"PANDA ON SUI", b"Panda Patin On SUI is memecoin inspired by Kungfu Panda film. we created a unique panda character to create a memecoin, This memecoin is on the SUI chain and can be bought at movepump.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/panda_sui_04bf38b744.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

