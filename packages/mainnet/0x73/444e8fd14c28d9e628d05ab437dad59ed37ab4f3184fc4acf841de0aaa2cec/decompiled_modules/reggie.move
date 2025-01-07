module 0x73444e8fd14c28d9e628d05ab437dad59ed37ab4f3184fc4acf841de0aaa2cec::reggie {
    struct REGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGGIE>(arg0, 9, b"REGGIE", b"REGGIE ", b"Welcome to the world of memes. I present to you Reggie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d55a3b5d-75de-48f3-b41b-ef57a6dc4446.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

