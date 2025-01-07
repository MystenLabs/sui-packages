module 0xd6e82a7c1cad06ad800d8d4b32cfe6d7997d97ac484e767c6be0212c62f444f::pepsui {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 6, b"PEPSUI", b"PEPSUI COIN", x"506570737569202d20536f6461207761746572206f66205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepsui_coin_2_dbce80c415.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

