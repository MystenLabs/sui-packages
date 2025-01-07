module 0x7834a9e9a79c69c267966c4962ff21b030a5066cca0ed4d47b64eef3fe7d6a9a::berlin {
    struct BERLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERLIN>(arg0, 9, b"berlin", b"berlin", b"pakis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BERLIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERLIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

