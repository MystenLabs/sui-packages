module 0x34c1a7b71833df988592df70ca9493c3a2505c4f2a3c630768b0eb409365c10d::rachu {
    struct RACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHU>(arg0, 6, b"RACHU", b"RAICHU", b"Raichu is a blockchain adventure where trainers capture digital Pokemon, trade with $Raichu tokens, and battle in cosmic arenas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibev67s5rsetwyfrtobxmqkivzvpnjcakbp57nfxjh5gkv5fcuh3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

