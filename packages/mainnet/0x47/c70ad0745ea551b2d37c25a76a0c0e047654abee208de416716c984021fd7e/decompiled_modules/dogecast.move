module 0x47c70ad0745ea551b2d37c25a76a0c0e047654abee208de416716c984021fd7e::dogecast {
    struct DOGECAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECAST>(arg0, 6, b"DOGECAST", b"Dogecast", b"Elon Musk and Vivek Ramaswamy livetream every week to update the American public of @DOGE's progress.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018527_db4e8d9d8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGECAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

