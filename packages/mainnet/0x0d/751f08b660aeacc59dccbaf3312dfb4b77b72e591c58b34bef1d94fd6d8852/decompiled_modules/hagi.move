module 0xd751f08b660aeacc59dccbaf3312dfb4b77b72e591c58b34bef1d94fd6d8852::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 6, b"HAGI", b"Hagi", b"Gheorghe Hagi, the best Romanian football player who is also known for his funny speeches, as he calls them \"mototo\" and which have become real memes over time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040954029.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

