module 0x3789ed2ede1d14f01533708957c66ea41d75da83eddb7b206dda8cfb4b53fd4f::USA {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"USA", b"MURRICA", b"merica caw caw!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmaDiRL4mPDxfbG25u1c34Jpkx1BqqhRpTK8hnkuTpcp2s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

