module 0x5c51cf54236bc127d055c166533da566ad5b70ac3ed83b30abdd560eb189bd5d::teston {
    struct TESTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTON>(arg0, 9, b"teston", b"testonsui", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTON>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

