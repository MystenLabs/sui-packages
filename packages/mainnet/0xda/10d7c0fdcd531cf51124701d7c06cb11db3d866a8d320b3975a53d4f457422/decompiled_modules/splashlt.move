module 0xda10d7c0fdcd531cf51124701d7c06cb11db3d866a8d320b3975a53d4f457422::splashlt {
    struct SPLASHLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHLT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHLT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHLT>(arg0, b"SPLASHlT", b"SplaSHlT", x"5468652053706c61736879206465762068617320736f6c642077697468206d756c7469706c652077616c6c65747320616e642064657374726f7965642074686520666972737420746f6b656e2e200a42656c6f7720697320746865206c696e6b20746f20746865206e657720746f6b656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZLjJ257iYLCU2A8vEXtLNA8T5WwYU499C3r84i95K2T7")), b"https://dexscreener.com/sui/0x4dd9caaf3775ece7a89355db76e3b1ca92481f69f791007119a33c8dc7da7886", b"TWITTER", b"DISCORD", b"https://t.me/splashy_CTO", 0x1::string::utf8(b"003effc06d6fc1cbbc64a9a106be98b82746de572e5cf6b0035589ee41b494a82b12a5a1e51fd4ade7ea49c018ee902855ec7194d089be036f63d72c0ce9db6e0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770008"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

