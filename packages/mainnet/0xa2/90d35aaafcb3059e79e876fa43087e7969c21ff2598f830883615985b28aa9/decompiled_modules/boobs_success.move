module 0xa290d35aaafcb3059e79e876fa43087e7969c21ff2598f830883615985b28aa9::boobs_success {
    struct BOOBS_SUCCESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS_SUCCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS_SUCCESS>(arg0, 9, b"BOOBS SUCCESS", b"BOOBS SUCCESS", b"just successfull boobs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOBS_SUCCESS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS_SUCCESS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBS_SUCCESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

