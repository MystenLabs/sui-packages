module 0x31e7275cb4607cc0c1b8b73b584093ebb5cd8661c06814d76f61414efe29c644::echox {
    struct ECHOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOX>(arg0, 9, b"ECHOX", b"EchoX Runner AI", b"The first-ever AI-powered voice-controlled game to life, introducing a fresh, innovative experience on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/df807e11434a8f4d247535725bcfec81blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

