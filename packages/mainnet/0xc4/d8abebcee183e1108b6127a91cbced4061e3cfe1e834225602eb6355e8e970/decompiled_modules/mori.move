module 0xc4d8abebcee183e1108b6127a91cbced4061e3cfe1e834225602eb6355e8e970::mori {
    struct MORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORI>(arg0, 6, b"MORI", b"Mori", b"Cool Death on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985227907.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

