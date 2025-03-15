module 0x9becfb224d6892a7da384d7d57534014386f1d6a7a639868a4ac9ca7ffda6f95::whiterock {
    struct WHITEROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITEROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITEROCK>(arg0, 6, b"WHITEROCK", b"WhiteRock", x"417320426c61636b526f636b207365656b7320746f2074616b65206f766572207468652063727970746f0a6d61726b65742c206669676874206261636b20616761696e737420796f757220636f72706f726174650a6f7665726c6f7264732077697468205768697465526f636b2e205768697465526f636b207365656b730a746f20676976652066696e616e6369616c20706f776572206261636b20746f207468652070656f706c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742070227061.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHITEROCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITEROCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

