module 0x24ff61ab85b1b5c7b491f28bbaf23a0da411c8ad1f4739a6d10df149afb994ab::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 9, b"CAP", b"CapFun", b"Just Spot and Chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c2c6b2d503ecb4c7c911963520896346blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

