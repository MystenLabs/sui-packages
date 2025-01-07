module 0x2af32fcb7439ef9a5bf2eb24f09e870798c38769af6af7d580b1c9bb3bff8b19::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 6, b"BLOO", b"Sui Bloo", b"BLOO laughs, BLOO memes, BLOO profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_0c12740854.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

