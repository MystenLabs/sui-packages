module 0x5265f4a20462f4735d90d0491cd538681fc1e5932571e8bf31424c23ad867f57::magna {
    struct MAGNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGNA>(arg0, 6, b"MAGNA", b"Magna AI by SuiAI", b"Magna redefines creativity with AI-driven art, turning your ideas into stunning visuals effortlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2236_244af0ff5e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGNA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

