module 0xbb25484679350e1c48fd26c3b81a889ed3b2cb2ad5163a4966de9824c572a916::cd {
    struct CD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CD>(arg0, 6, b"CD", b"chill dude", b"first time for fun on sui bolckchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CD>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CD>>(v1);
    }

    // decompiled from Move bytecode v6
}

