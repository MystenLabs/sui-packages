module 0x4993bb6ec53fc67058ad019d7c787cb4c9e7806a0640006ce9083d777e9230f8::tr {
    struct TR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR>(arg0, 9, b"TR", b"trump", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/19c66d6666ca29c2465910cf0e70ecbcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

