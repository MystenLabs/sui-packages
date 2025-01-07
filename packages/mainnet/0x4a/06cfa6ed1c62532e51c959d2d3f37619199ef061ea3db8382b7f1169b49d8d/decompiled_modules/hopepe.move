module 0x4a06cfa6ed1c62532e51c959d2d3f37619199ef061ea3db8382b7f1169b49d8d::hopepe {
    struct HOPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPEPE>(arg0, 12637011198525304410, b"Hopepe", b"HOPEPE", x"486f5065706520746f20746865206d6f6f6e207765e28099726520666c79696e6720686967680a466f7274756e6573206f6e207468652072697365206c696b6520746865206d6f726e696e6720736b790a4576657279206c6974746c6520636f696e20706176696e6720746865207761790a52696368657320706f7572696e6720696e206561636820616e6420657665727920646179", b"https://images.hop.ag/ipfs/Qma2bv9YjSP7agbWpvnmF4NwUSMheitXRhydFLaidR2AVN", 0x1::string::utf8(b"https://x.com/Hopepe_sui"), 0x1::string::utf8(b"https://hopepe.online"), 0x1::string::utf8(b"https://t.me/Hopepe_Sui"), arg1);
    }

    // decompiled from Move bytecode v6
}

