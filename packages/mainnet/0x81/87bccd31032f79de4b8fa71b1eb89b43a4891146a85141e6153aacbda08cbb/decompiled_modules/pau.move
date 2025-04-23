module 0x8187bccd31032f79de4b8fa71b1eb89b43a4891146a85141e6153aacbda08cbb::pau {
    struct PAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAU>(arg0, 9, b"PAU", b"Paulo", b"Buy it, you won't regret it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6d26522250e080474af0d0aa472aa4eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

