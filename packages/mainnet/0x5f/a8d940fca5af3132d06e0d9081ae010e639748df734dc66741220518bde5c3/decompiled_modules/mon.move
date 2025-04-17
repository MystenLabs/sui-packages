module 0x5fa8d940fca5af3132d06e0d9081ae010e639748df734dc66741220518bde5c3::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"Mon", b"monad on sui", b"emjoy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e1e2a5aa5a484c173bbfeb84e48f19c5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

