module 0xb1f7751908b3a2d0d07f3742d99eb8ed662e1c5de288c161e7b5b65dfa1dd5bc::niel {
    struct NIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIEL>(arg0, 6, b"Niel", b"Niel Armstrong", x"4e45494c202d20496e737069726564206279204e65696c2041726d7374726f6e672077686f206669727374206c616e646564206f6e20746865206d6f6f6e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001577_9695b519ec_753cd6d485.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

