module 0x6f1fdb03814c8afff5226987820a124d3bf6cd17767ef21e1a40787a20520f1c::stellla {
    struct STELLLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STELLLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STELLLA>(arg0, 9, b"STELLLA", b"Stella Token", b"A new token on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STELLLA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STELLLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STELLLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

