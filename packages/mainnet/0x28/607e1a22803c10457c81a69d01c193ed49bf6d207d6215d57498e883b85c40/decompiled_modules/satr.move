module 0x28607e1a22803c10457c81a69d01c193ed49bf6d207d6215d57498e883b85c40::satr {
    struct SATR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATR>(arg0, 6, b"SatR", b"SATOSHI REVEAL", b"This belongs to satoshi nakamoko REVEAL By HBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bitcoin_creator_satoshi_nakamoto_v01_67677ca91b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATR>>(v1);
    }

    // decompiled from Move bytecode v6
}

