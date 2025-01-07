module 0xcf40649cac0b4ea7350ca659cd2402aa3853851b6074f14dc0e8e5db12da5cf::trumpwinelon {
    struct TRUMPWINELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWINELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWINELON>(arg0, 6, b"TRUMPWINELON", b"TRUMP WIN-ELON MUSK", b"ELON MUSK SAY TRUMP WIN, AND ELON ALSO FUNDING DONNALD TRUMP PARTY & SUPPORT HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elon_and_Trump_1784094154.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWINELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWINELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

