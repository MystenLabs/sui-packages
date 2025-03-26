module 0xd4b0467b9bc9b49c624adddcc0992608582b857529215466ed4cb6a10e7b7995::dustbin {
    struct DUSTBIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUSTBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUSTBIN>(arg0, 6, b"DUSTBIN", b"Dustbin", b"The First Dustbin on the Moon.Put your dust here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012140_f6d5e7e0f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUSTBIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUSTBIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

