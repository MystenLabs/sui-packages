module 0xb9c93f78369cef485b418f3b867d90ab5a07e3090d93fd8b1da764d989c7507f::cragy {
    struct CRAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAGY>(arg0, 6, b"CRAGY", b"Cragy Guy", b"JUST A CRAGY GUY - Our goal is to make Cragy guy a real and long - Lasting meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021604_9c8613b258.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

