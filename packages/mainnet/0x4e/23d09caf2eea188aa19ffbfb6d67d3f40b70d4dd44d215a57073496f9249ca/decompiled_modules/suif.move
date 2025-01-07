module 0x4e23d09caf2eea188aa19ffbfb6d67d3f40b70d4dd44d215a57073496f9249ca::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"suiF", b"suiFrogs", b"the first frog from sui is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_aa290a6f50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

