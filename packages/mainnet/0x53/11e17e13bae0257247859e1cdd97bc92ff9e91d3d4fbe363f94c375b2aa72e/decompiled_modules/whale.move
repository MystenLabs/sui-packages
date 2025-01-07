module 0x5311e17e13bae0257247859e1cdd97bc92ff9e91d3d4fbe363f94c375b2aa72e::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 9, b"WHALE", b"WHALE", b"From 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/9sje9S0FDEIAAAAC/beluga.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

