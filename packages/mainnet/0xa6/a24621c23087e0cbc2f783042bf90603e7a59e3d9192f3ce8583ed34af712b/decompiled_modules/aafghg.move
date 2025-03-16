module 0xa6a24621c23087e0cbc2f783042bf90603e7a59e3d9192f3ce8583ed34af712b::aafghg {
    struct AAFGHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAFGHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAFGHG>(arg0, 9, b"Aafghg", b"gfh", b"fgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f5b068666daaf6b791a1d0e4eb2706b1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAFGHG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAFGHG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

