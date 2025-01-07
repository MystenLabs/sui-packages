module 0x589c512659a44ae248db51a1ddf2bba7c6306bacf39608ea067f5278221c366c::jtc {
    struct JTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTC>(arg0, 6, b"JTC", b"justice", b"The fairest token, the contract creator only buys it for $3, multiple wallets can buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c72a63b8_e15e_4aed_8ab3_cf5437b4cd58_01ab7fea74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

