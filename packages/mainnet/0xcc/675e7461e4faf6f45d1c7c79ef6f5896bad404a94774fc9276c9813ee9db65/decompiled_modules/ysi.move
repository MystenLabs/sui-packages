module 0xcc675e7461e4faf6f45d1c7c79ef6f5896bad404a94774fc9276c9813ee9db65::ysi {
    struct YSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSI>(arg0, 6, b"YSI", b"YESONSUI", b"This meme token of YES COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mqdefault_9ed27e9899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

