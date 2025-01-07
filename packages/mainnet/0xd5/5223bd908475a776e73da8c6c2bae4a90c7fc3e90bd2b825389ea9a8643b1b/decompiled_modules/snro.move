module 0xd55223bd908475a776e73da8c6c2bae4a90c7fc3e90bd2b825389ea9a8643b1b::snro {
    struct SNRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNRO>(arg0, 6, b"SNRO", b"SUINEIRO", b"SUINEIRO is the ultimate meme token on SUI! Inspired by the adventurous spirit of the Neiros, SUINEIRO blends fun with a passionate community, always on the lookout for the next big opportunity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINEIRO_2b00f2c071.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

