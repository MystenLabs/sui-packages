module 0xe1ecf0735664005835c9727b8935e830df3de581b5b547a3efc5c3702508dd84::errorsui {
    struct ERRORSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERRORSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERRORSUI>(arg0, 6, b"ERRORSUI", b"404 Error SUI", b"404 Error SUI is a memecoin inspired by the notorious 404 error page and the fast-paced world of Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ERRORSUI_2_64455018ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERRORSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERRORSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

