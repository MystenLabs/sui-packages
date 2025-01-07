module 0xdce05146fc1cb18640752e015332a73bba8817cbc9c3912372b9b59aa2bd1492::hnysui {
    struct HNYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNYSUI>(arg0, 9, b"HNYSUI", b"HAPPY NEW SUI COIN", b"HNYSUI and Inspektor SUI wishes everyone a happy new year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1ba196ac2010e8d8c38d6374a36cc566blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNYSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

