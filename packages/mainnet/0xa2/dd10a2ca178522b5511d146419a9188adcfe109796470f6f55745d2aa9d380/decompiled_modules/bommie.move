module 0xa2dd10a2ca178522b5511d146419a9188adcfe109796470f6f55745d2aa9d380::bommie {
    struct BOMMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMMIE>(arg0, 6, b"BOMMIE", b"Bommie Sui", b"BOMMIE The community is the dev!  Together, we build, grow, and reach for the moon.  Lets make history!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009945_fef2632237.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

