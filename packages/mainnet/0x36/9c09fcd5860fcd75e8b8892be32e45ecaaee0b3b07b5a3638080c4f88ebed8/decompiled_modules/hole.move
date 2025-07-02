module 0x369c09fcd5860fcd75e8b8892be32e45ecaaee0b3b07b5a3638080c4f88ebed8::hole {
    struct HOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLE>(arg0, 9, b"HOLE", b"$HOLE", b"First token HOLE Finance:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/77e99430680b2f4c124444012d7f9ca3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

