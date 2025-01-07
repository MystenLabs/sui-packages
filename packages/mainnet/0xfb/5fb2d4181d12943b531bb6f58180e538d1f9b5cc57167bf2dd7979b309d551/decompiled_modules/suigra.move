module 0xfb5fb2d4181d12943b531bb6f58180e538d1f9b5cc57167bf2dd7979b309d551::suigra {
    struct SUIGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGRA>(arg0, 6, b"SUIGRA", b"The Blue Pill", x"426c75652070696c6c20737a6e206f6e205375692e200a245355494752412020746865206f6e6c7920707265736372697074696f6e20796f75206e65656420666f722074686f7365206c696d70206368617274732e0a4e6f20646f63746f722c206e6f207369646520656666656374732c206a757374207075726520706572666f726d616e63652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9087_37e394a3ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

