module 0xb65c9b97f942b78fe5e06d60316b5333bf7f8127a179a21a4c2138739ec9c073::mono {
    struct MONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONO>(arg0, 6, b"MONO", b"Sui Monopoly", b"Sui Monopoly is lundry you money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037897_4d87c7836c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

