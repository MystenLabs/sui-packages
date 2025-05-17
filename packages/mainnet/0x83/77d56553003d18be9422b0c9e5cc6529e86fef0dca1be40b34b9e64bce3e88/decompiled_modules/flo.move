module 0x8377d56553003d18be9422b0c9e5cc6529e86fef0dca1be40b34b9e64bce3e88::flo {
    struct FLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLO>(arg0, 9, b"FLO", b"FLOKI", x"464c4f4b4920697320746865207574696c69747920746f6b656e206f662074686520466c6f6b692065636f73797374656d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2bff46734a53890e62dade644138a867blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

