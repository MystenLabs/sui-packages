module 0x1b6becd910d073718772cb68201a9e44cc719c3b32e369f24bd724fa45ecd51d::b_punk {
    struct B_PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PUNK>(arg0, 9, b"bPUNK", b"bToken PUNK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

