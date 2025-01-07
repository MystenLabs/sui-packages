module 0xd1110816284cf6bf485b33c79a1c59d17fa12a4c8bbbb57cf08642c2f298a7f2::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RABBIT>(arg0, 6, b"RABBIT", b"RABBIT FACE", b"SuiEmoji Rabbit Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/rabbit.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RABBIT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

