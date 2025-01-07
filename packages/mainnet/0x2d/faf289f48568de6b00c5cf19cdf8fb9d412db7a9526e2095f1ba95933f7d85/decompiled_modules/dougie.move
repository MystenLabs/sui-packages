module 0x2dfaf289f48568de6b00c5cf19cdf8fb9d412db7a9526e2095f1ba95933f7d85::dougie {
    struct DOUGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUGIE>(arg0, 6, b"DOUGIE", b"Dougie", b"$DOUGIE SUI'S FIRST A.I. PUG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021642_daba005fc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

