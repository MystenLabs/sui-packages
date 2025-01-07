module 0xbbb65ec347771db056f0110f27006574a93184267856aa02d51f3c94a10fa9d6::kurwa {
    struct KURWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURWA>(arg0, 9, b"KURWA", b"KURWA SUIBOBER", b"JA PERDOLE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KURWA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURWA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KURWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

