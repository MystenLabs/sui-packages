module 0xfd51ca4789933ee5f94e6c986c4315e92d5bf610c9a3fdce13594f1d8b406dce::number {
    struct NUMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUMBER>(arg0, 9, b"number", b"number2", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUMBER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUMBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

