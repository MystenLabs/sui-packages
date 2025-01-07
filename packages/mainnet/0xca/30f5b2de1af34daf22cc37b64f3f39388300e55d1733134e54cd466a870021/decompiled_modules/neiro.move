module 0xca30f5b2de1af34daf22cc37b64f3f39388300e55d1733134e54cd466a870021::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Suiper Neiro", x"537569706572204e6569726f20696e73706972656420646f7a656e73206f66206d656d6520636f696e73206f6e20536f6c616e6120616e6420457468657265756d2c20696e636c7564696e67204669727374204e6569726f206f6e20457468657265756d2e2054686520244e4549524f206d656d6520636f696e2069732064657369676e656420656e746972656c7920666f722074726164696e6720616e6420686173206e6f206f74686572207574696c6974696573206f722066656174757265732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039986_8aea06697d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

