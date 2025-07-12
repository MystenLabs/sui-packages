module 0x3145544aac0c4b9a8717d417aca66b202c1e5fe5aed2c0cd61f18301f0a7e28d::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 9, b"MM", b"mondeemonster", b"Lost relic of the olden days, Once revered for his vast knowledge and pure heart but because of a betral has turned him to a demon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/484f0341c16a4e1d7b8db3b362057c0cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

