module 0xdbef0f6043d4e3373fc7e269d36edbe6dd30aa8888c0750bece9530fa273a76f::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GME on SUI by SuiAI", b"The official $SUI Community coin of @wallstreetbets. WE ARE NOT SELLING.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Logo_fe447477a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

