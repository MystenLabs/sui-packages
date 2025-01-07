module 0x19017c8ef04366539e6ca5d60fdef5f6c8ca8c348290d7ff2ae08f8db942f876::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"Biaoqing", b" $BIAO is a memecoin inspired by the most famous Chinese meme representing facial expressions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BIAO_e5f6c6a002.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

