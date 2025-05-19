module 0x464cdb69a85e04b949f9e7df7ab8065cd24607392aa2376488065d4957b56ef8::gzs {
    struct GZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZS>(arg0, 6, b"GZS", b"GAINZ SUI", x"4e6f207765616b2068616e64732e204a757374206469616d6f6e642064656c74732e0a0a4d696e65206761696e732c206e6f7420636f696e732e0a0a4c697175696469747920746f206f75746c69766520796f75722065782e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihz44fo3cuuq33a6xgg5rrxttjnhi4kggaia2rsvptoztkxakpc2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GZS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

