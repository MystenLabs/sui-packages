module 0xfef4227116451be7dcb52c08e78de6fe8cde651bedfbf8d0c80f83171234f1ad::grabby {
    struct GRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRABBY>(arg0, 6, b"GRABBY", b"Grabby", b"Moves quicker than your Wi-Fi on payday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dd4dbb974bd9fbacce786ec25c466c73_ebb1488cef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

