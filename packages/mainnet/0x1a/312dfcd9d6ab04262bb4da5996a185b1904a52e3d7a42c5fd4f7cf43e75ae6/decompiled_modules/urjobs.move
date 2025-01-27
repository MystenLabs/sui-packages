module 0x1a312dfcd9d6ab04262bb4da5996a185b1904a52e3d7a42c5fd4f7cf43e75ae6::urjobs {
    struct URJOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: URJOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URJOBS>(arg0, 9, b"URJOBS", b"TheyTookUrJobs Coin", x"53746f702050656f706c652066726f6d20746865206675747572652066726f6d2074616b696e67206f7572206a6f62732077697468207468697320636f696e2121210a5468657920546f6f6b205572204a6f6273212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/141d010df8f4a76dca85c1358973aca8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<URJOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URJOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

