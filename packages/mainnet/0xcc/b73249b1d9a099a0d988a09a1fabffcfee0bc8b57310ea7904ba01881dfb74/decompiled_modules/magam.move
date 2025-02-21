module 0xccb73249b1d9a099a0d988a09a1fabffcfee0bc8b57310ea7904ba01881dfb74::magam {
    struct MAGAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAM>(arg0, 6, b"MAGAM", b"MagaMusk", b"MagaMusk Making Memes Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4920_7f22cedb0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

