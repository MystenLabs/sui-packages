module 0x6414499c39895f13cd04b19d12d9237345a1a4f9805dabe02ec00a08d9f0887f::magadonalds {
    struct MAGADONALDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGADONALDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGADONALDS>(arg0, 6, b"MagaDonalds", b"MagaDonald's", x"5374617274656420627920535549206d617869732c206c6f6f6b696e6720746f20646f6d696e617465207468652053756920626c6f636b636861696e2e0a0a576520617265206275696c64696e672072656c6174696f6e736869707320616e6420776f726b696e6720756e69746564206173206f6e6520666f7220746865206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gaa4_YSIW_8_A_Aa_M7_D_c39825289f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGADONALDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGADONALDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

