module 0xc6285e70ea7c05175532fbcf384385d2655bfd3b827062fbf73f3319ba254a5b::apes {
    struct APES has drop {
        dummy_field: bool,
    }

    fun init(arg0: APES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APES>(arg0, 6, b"APES", b"Ape Sui Society", x"546865204170657320686176652065766f6c76656420616e64207374617274656420746f20636f6e71756572200a405375694e6574776f726b0a206d6f7265206167677265737369766520616e6420636f6f6c207468616e206576657220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5833331012454_d76c5e279bc7b036fdd4858fc206ffc7_3403dada33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APES>>(v1);
    }

    // decompiled from Move bytecode v6
}

