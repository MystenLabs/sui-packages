module 0x490635b340991d62000d9b01449629af505758ba7bb0d7013b6ff02d4315dcf4::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 6, b"KITTY", b"KITTY on SUI", b"Hello. we are $kitty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_3jq_Mw4_400x400_8369307dfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

