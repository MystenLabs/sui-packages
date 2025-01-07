module 0xc6cb9667565a56ca7c1fd411ec0e15bca1b9f15131e559f1447995618110788d::suikem {
    struct SUIKEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEM>(arg0, 6, b"SuiKem", b"Kem Jeng Un", b"Mek meme gret egen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U6_Yypb_AX_400x400_6cf1630978.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

