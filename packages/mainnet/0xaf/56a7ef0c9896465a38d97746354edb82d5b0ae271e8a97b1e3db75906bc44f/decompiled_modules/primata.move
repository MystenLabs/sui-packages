module 0xaf56a7ef0c9896465a38d97746354edb82d5b0ae271e8a97b1e3db75906bc44f::primata {
    struct PRIMATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIMATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMATA>(arg0, 6, b"PRIMATA", b"PRIMATA SUI", x"245052494d415441206f70657261746573206f6e207468652062616e616e61207374616e646172642e204561636820245052494d415441206973206261636b6564206279207468652070726f6d697365206f66206f6e65207669727475616c2062616e616e612c20656e737572696e6720796f757220696e766573746d656e7420697320617320667275697466756c2061732061207261696e666f7265737420747265652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hd_Gj_J_Wl_G_400x400_0d1a0386ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIMATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

