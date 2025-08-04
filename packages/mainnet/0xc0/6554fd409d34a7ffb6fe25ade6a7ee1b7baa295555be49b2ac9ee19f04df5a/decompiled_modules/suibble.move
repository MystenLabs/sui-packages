module 0xc06554fd409d34a7ffb6fe25ade6a7ee1b7baa295555be49b2ac9ee19f04df5a::suibble {
    struct SUIBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBBLE>(arg0, 9, b"suibble", b"suibble", b"suibbles bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suibble.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBBLE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBBLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

