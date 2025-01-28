module 0x7c9cee9ead9e65d28b05997b5785a17cc27536d0ad5b60af63d7c9876a4b54f3::anus {
    struct ANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANUS>(arg0, 6, b"ANUS", b"DeepSeek URANUS AI by SuiAI", b"The first agent to help you check the surface and insides of URANUS using deepseek-R1..Buthole and fartcoin holders are frequent users off deepseek uranus AI tech", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1a80834a_da84_4051_8a15_c7f41faa9d3e_cac5812e45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

