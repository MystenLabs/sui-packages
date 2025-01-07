module 0x9e8a7b3be7e3d5ac16e139fbc9bcc4e5992dec1951318b49d74293c34e47dacf::fans {
    struct FANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANS>(arg0, 9, b"FANS", b"4FANS", b"On-chain fans unite! Exclusive content, zero middlemen, and a sprinkle of blockchain magic. Welcome to the future of fun! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c7b0ab4b3fcf3e226d22aa3389d50f81blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FANS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

