module 0xb399ea7eb7ee877a9720bce9077182c0f2b73e8351c443f328a9d6c5c8e44fd7::domino {
    struct DOMINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOMINO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOMINO>(arg0, 6, b"DOMINO", b"Domino by SuiAI", b"DOMINO is a blockchain-based utility token designed to support and enhance the development, deployment,and maintenance of Telegram bots..https://t.me/DominoSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/o_Xa_C37d_N_400x400_9ef9642161.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOMINO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOMINO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

