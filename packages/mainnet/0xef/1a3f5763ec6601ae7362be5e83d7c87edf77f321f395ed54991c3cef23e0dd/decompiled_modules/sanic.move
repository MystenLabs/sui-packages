module 0xef1a3f5763ec6601ae7362be5e83d7c87edf77f321f395ed54991c3cef23e0dd::sanic {
    struct SANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIC>(arg0, 6, b"SANIC", b"First Sanic Coin on Sui", b"First Sanic Coin on Sui: https://www.saniccoinsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_16_de43d0a5ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

