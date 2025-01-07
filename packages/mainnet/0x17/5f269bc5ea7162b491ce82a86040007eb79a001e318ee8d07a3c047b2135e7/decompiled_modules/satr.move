module 0x175f269bc5ea7162b491ce82a86040007eb79a001e318ee8d07a3c047b2135e7::satr {
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

