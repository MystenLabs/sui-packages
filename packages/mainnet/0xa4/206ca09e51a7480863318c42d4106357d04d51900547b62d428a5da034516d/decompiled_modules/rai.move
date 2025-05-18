module 0xa4206ca09e51a7480863318c42d4106357d04d51900547b62d428a5da034516d::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAI>(arg0, 6, b"RAI", b"RAICHU", b"raichhu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif6yz4gdrpuccu2k4v5o7ukhpafhqvgxpksqqmtrh2wgw2cs4naxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

