module 0x318b90e9caa3114eefb3c7c45d9abaabae04e22f337ae9dcba1d07d639f03a8a::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SUPASUI", x"41726520796f7520726561647920666f7220746865202453555041204c61756e63682070617274793f0a57656c636f6d6520746f205355504120776f726c64212121416c6c20686f646c6572732077696c6c206265207472756520535550412c20536f2057656e3f205665727920534f4f4e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018204_e224fa4269.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

