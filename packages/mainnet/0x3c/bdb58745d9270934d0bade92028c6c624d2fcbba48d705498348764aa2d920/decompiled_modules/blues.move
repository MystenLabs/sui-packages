module 0x3cbdb58745d9270934d0bade92028c6c624d2fcbba48d705498348764aa2d920::blues {
    struct BLUES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUES>(arg0, 9, b"BLUES", b"Blue Eyed Seal", b"blue eyed animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUES>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUES>>(v1);
    }

    // decompiled from Move bytecode v6
}

