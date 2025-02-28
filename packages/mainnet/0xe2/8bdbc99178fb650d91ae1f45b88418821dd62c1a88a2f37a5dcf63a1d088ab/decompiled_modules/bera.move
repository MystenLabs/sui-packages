module 0xe28bdbc99178fb650d91ae1f45b88418821dd62c1a88a2f37a5dcf63a1d088ab::bera {
    struct BERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERA>(arg0, 9, b"BERA", b"Bera Token", b"A test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BERA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

