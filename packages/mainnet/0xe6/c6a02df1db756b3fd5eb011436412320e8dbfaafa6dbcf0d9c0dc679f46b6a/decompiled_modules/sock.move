module 0xe6c6a02df1db756b3fd5eb011436412320e8dbfaafa6dbcf0d9c0dc679f46b6a::sock {
    struct SOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCK>(arg0, 6, b"SOCK", b"Just a Christmas Sock", b"$SOCK isnt just another coin its a holiday revolution. Its about spreading joy, laughter, and cheer to every wallet on the blockchain. Whether youve been naughty or nice, $SOCK is the perfect Christmas surprise that wont get lost behind the couch like regular socks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66_K8_Ys_X_Awhscsj_Ax_Qcrhn_F8s_Yky_XCEEYSLBFQ_Eged6_X9_8381213302.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

