module 0xce86d7ea50c7b3ac6312c4c21d31c5fe53cbe7b70765669a6c6a16259287717c::magna {
    struct MAGNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNA>(arg0, 6, b"Magna", b"Magna AI", b"Magna redefines creativity with AI-driven art, turning your ideas into stunning visuals effortlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737728748977.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

