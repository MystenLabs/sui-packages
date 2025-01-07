module 0x39869a9464cb4b8de00648a1d83e029e4854b1b7723c5a112e930475c90d68b7::ip {
    struct IP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IP>(arg0, 6, b"IP", b"I PHONE", b"Just a phone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1717318362240_0174e12e54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IP>>(v1);
    }

    // decompiled from Move bytecode v6
}

