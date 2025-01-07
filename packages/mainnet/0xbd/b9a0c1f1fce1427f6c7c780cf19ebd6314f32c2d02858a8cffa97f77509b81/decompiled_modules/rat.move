module 0xbdb9a0c1f1fce1427f6c7c780cf19ebd6314f32c2d02858a8cffa97f77509b81::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAT>(arg0, 6, b"RAT", b"Rat Bastard", b"The Rat Bastard of New York", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rattt_4a12070ef7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

