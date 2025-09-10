module 0x898f6858f24a64ba8d72c8d8a230fc327758db321a93292d906c79bc50901ab6::Iphone {
    struct IPHONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPHONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPHONE>(arg0, 9, b"IPHONE", b"Iphone", b"iphone 17", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0cwbetbgAAo3wt?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPHONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPHONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

