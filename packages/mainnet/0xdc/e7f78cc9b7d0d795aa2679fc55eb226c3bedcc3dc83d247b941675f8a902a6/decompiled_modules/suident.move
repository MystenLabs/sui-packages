module 0xdce7f78cc9b7d0d795aa2679fc55eb226c3bedcc3dc83d247b941675f8a902a6::suident {
    struct SUIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENT>(arg0, 6, b"SUIDENT", b"Sui Trident", x"546865206c6567656e646172792054726964656e74206f66205375692c20666f7267656420696e207468652064656570657374207761746572732c206e6f7720726973657320746f20636c61696d2069747320706f77657221205769656c64656420627920746865206d69676874696573742c202453554944454e54206368616e6e656c732074686520737472656e677468206f662074686520537569204e6574776f726b2e2057696c6c20796f752074616b6520686f6c64206f66207468652074726964656e7420616e6420636f6d6d616e64207468652077617665733f2054686520706f77657220697320796f7572732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIDENTFIXED_1_0216a69285.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

