module 0x27773692259354870eba7c361dce8cb3af9693c23b4394d8100d48782eb3d53::horsea {
    struct HORSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSEA>(arg0, 6, b"HORSEA", b"HorseaSui", x"486f727365612069732061205761746572207479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e2031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicip53dz4savauiac2vqf5hmas2fwck2lpp2hz7qc5jetwx2mvzty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORSEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

