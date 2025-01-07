module 0x764c0c4db1ccb12b2cf00af7da788b94e08cd6fba3595a8374fb43040fc6dd43::fuentes {
    struct FUENTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUENTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUENTES>(arg0, 6, b"FUENTES", b"NICK", b"The best Fuentes on the SUI, inspired by the combine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nick_db21d139e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUENTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUENTES>>(v1);
    }

    // decompiled from Move bytecode v6
}

