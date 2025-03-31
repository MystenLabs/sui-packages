module 0xfb5f672a8351a2ebd5af891df5c5fea9add389d6f08263039a5cce5270f2d061::dont {
    struct DONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONT>(arg0, 9, b"DONT", b"DONT BUY", b"BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY BUY DONT BUY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/44d42fa50ccd3d3e31aa19cc6614e71ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

