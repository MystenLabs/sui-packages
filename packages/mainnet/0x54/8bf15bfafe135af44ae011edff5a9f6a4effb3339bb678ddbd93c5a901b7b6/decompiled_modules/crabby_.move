module 0x548bf15bfafe135af44ae011edff5a9f6a4effb3339bb678ddbd93c5a901b7b6::crabby_ {
    struct CRABBY_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABBY_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABBY_>(arg0, 9, b"CRABBY", x"43524142425920f09fa68020f09fa680", x"f09fa68020f09fa68043726162436f696e20697320616c6c2061626f75742074686520756e73746f707061626c652c2062756c6c6973682076696265206f662074686520537569206e6574776f726b2e204c696b65206120746f756768206c6974746c6520637261622c207468697320636f696e2073637574746c6573207369646577617973207468726f75676820746865206d61726b65742c206a7573742077616974696e6720666f7220746865207269676874206d6f6d656e7420746f206d616b6520697473206d6f7665207768656e207468652074696d652069732072696768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRABBY_>(&mut v2, 6000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABBY_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABBY_>>(v1);
    }

    // decompiled from Move bytecode v6
}

