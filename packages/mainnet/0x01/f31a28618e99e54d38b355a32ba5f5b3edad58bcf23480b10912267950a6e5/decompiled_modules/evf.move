module 0x1f31a28618e99e54d38b355a32ba5f5b3edad58bcf23480b10912267950a6e5::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"EVOFROGSUI", b"EvoFrog is not just another meme coin - it's an evolutionary journey on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiglsw5uot4d4tmgx24jdacbto3upwoiybl7nxz3oz4ypmodnyvvv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

