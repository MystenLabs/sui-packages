module 0xfaad8f3f009465f39754a4f33c757234c8b2e9761c3564c1df4e87f27ddc0920::egb {
    struct EGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGB>(arg0, 6, b"EGB", b"EagleBoy On Sui", b"$EGB IS A MEME PROJECT ON SUI BLOCKCHAIN END COMUNITY GROW UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_015247_8592176177.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

