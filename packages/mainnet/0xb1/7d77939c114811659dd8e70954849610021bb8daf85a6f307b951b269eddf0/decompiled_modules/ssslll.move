module 0xb17d77939c114811659dd8e70954849610021bb8daf85a6f307b951b269eddf0::ssslll {
    struct SSSLLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSLLL>(arg0, 9, b"SSSLLL", b"SSL", b"SSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSSLLL>(&mut v2, 3457874323000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSLLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSLLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

