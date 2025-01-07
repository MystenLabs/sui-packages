module 0x773801c4c3f849aad7375ca879b177fb2aa38224b5fb8cbf6f46a61290285c16::pansui {
    struct PANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANSUI>(arg0, 6, b"PANSUI", b"PANDA PATIN ON SUI", b"Panda Patin On SUI is memecoin inspired by Kungfu Panda film. we created a unique panda character to create a memecoin, This memecoin is on the SUI chain and can be bought at movepump.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/panda_sui_77998a61f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

