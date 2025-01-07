module 0x4de574e04c242e9ba9f862fc798588e1d8534155479d4f38f6b5eed2e19523f6::masui {
    struct MASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASUI>(arg0, 6, b"MASUI", b"Masui", b"The little blue cat with huge eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/masui_35a3595e39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

