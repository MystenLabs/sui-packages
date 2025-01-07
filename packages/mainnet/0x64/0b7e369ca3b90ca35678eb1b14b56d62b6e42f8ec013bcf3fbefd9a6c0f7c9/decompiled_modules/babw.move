module 0x640b7e369ca3b90ca35678eb1b14b56d62b6e42f8ec013bcf3fbefd9a6c0f7c9::babw {
    struct BABW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABW>(arg0, 9, b"BABW", b"Baby Whale", b"BABW pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_qkYxt2046Qo6dS2qKBt9K1UkF3fQ-1TU-OKYiyhH2hTSbuzRV_xynIFziAwbbeC-cYY&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABW>>(v1);
    }

    // decompiled from Move bytecode v6
}

