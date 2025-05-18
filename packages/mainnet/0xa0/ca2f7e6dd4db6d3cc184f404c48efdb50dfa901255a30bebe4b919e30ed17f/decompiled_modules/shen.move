module 0xa0ca2f7e6dd4db6d3cc184f404c48efdb50dfa901255a30bebe4b919e30ed17f::shen {
    struct SHEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEN>(arg0, 6, b"Shen", b"Suishen", x"546865205068616e746f6d20526976657220466f780a547970653a2057617465722f47686f73740a4f726967696e3a20412073686170652d7368696674696e672073706972697420626f726e2066726f6d20746865206669727374207465617273206f6620746865206d6f6f6e2c205375697368656e2069732074686520677561726469616e206f6620666f72676f7474656e2072697665727320616e6420746865206775696465206f66206c6f737420736f756c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747597292692.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

