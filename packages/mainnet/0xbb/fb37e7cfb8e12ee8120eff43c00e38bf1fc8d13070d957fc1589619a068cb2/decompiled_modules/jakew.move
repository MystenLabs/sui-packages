module 0xbbfb37e7cfb8e12ee8120eff43c00e38bf1fc8d13070d957fc1589619a068cb2::jakew {
    struct JAKEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAKEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKEW>(arg0, 9, b"JAKEW", b"Jake", b"WANDERER TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e588e924480d750fc5533a30c40b6abbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAKEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAKEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

