module 0xde07a4391f89938cb467b2465ec0c6cd3b7b01ee9b6c539ac2ee47e39feb805a::skm {
    struct SKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKM>(arg0, 6, b"SKM", b"SITISI NIKIMITI", b"MEME satoshi nakamoto real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/satoshi_nakamto_1bb7ffb454.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKM>>(v1);
    }

    // decompiled from Move bytecode v6
}

