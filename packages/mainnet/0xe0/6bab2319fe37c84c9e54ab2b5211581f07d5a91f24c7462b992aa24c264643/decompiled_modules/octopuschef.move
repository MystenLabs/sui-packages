module 0xe06bab2319fe37c84c9e54ab2b5211581f07d5a91f24c7462b992aa24c264643::octopuschef {
    struct OCTOPUSCHEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUSCHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUSCHEF>(arg0, 6, b"OCTOPUSCHEF", b"octopus chef", b"Get ready. We're about to eat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_07_53_00_d3f6bf23bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUSCHEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUSCHEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

