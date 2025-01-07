module 0xb3b80444c11018197283bba1445f3d6ce319e1026b068e271747964d0481406b::goldpig {
    struct GOLDPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDPIG>(arg0, 6, b"GoldPiG", b"GoldPig", x"50696773206861766520616c776179732062726f7567687420666f7274756e652e20427579696e67207468697320636f696e2077696c6c206272696e6720796f75206772656174206c75636b2e20457370656369616c6c792c206120676f6c64656e207069672077696c6c206272696e6720796f7520696d6d656e7365207765616c74680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gold_Pig_T_Wegr_V_M528_H9p_WAE_Jv_d95a603b77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

