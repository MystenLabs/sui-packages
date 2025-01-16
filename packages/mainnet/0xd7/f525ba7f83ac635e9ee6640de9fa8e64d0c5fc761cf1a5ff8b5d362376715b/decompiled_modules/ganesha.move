module 0xd7f525ba7f83ac635e9ee6640de9fa8e64d0c5fc761cf1a5ff8b5d362376715b::ganesha {
    struct GANESHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANESHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GANESHA>(arg0, 6, b"GANESHA", b"GANESHA AI by SuiAI", x"54686520776973646f6d206f662074686520656c657068616e7420676f64206d656574732074686520706f776572206f662041492e20427265616b2062617272696572732c20696c6c756d696e6174652070617468732c20616e6420616368696576652066696e616e6369616c2073756363657373207769746820612063727970746f206275696c7420666f7220746865206675747572652e20f09f9589efb88ff09f9098", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/r04_N_Ec_CX_400x400_7370b32814.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GANESHA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANESHA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

