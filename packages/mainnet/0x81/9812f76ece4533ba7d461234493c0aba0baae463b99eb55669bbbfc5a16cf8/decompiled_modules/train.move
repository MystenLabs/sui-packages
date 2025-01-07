module 0x819812f76ece4533ba7d461234493c0aba0baae463b99eb55669bbbfc5a16cf8::train {
    struct TRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAIN>(arg0, 6, b"TRAIN", b"HYPE TRAIN", b"We are on the Move", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1efe630614.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

