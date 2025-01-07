module 0xb1fcde48686df1383582170d99d7c9604b00b214f9dae038b5c7bdac71825c84::chalk {
    struct CHALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHALK>(arg0, 6, b"Chalk", b"Chalk on Sui", b"just a chalk dude on  @SuiNetwork   Join Telegram : Chalksuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_W_U_Ei_Rk_400x400_c79284d91a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

