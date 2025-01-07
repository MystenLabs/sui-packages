module 0x6b82e8653964eff0c2368004398fbca6a38d1ae2df83aef4cf289449a5f513c9::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 6, b"SMOON", b"Suilor Moon", b"01010011 01101110 01101001 01110000 01100101 01110010 00100000 01110100 01100101 01110011 01110100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SMOON_ab6f9d1e08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

