module 0xc5beecd21d1a4639b9458002357b5834067ea34e3dc79fc73e1d1685d6c1c589::suwu {
    struct SUWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWU>(arg0, 6, b"SUWU", b"uWu on SUI", b"uWu on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hni_Dm_VR_400x400_173cc914e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

