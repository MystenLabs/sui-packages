module 0xcbd299892bae76aa0c5574b4d6bcbfb8f25d55063e51017abe78b35cf5a0ea88::bbks {
    struct BBKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBKS>(arg0, 6, b"BBKS", b"BLUEBucks", b"CryptoClaws is living that deep-sea high life, counting stacks of BlueBucks while staying chill at the bottom of the ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241012_133535_717_9517b4f1b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

