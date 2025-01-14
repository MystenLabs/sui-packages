module 0x7dd2d00d52f61a3f22725be99ca8da3bc58ed43534a241edc5eb03e2a6d63a6a::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 6, b"PET", b"Puzzle Engine Technology", b"Everyone needs a pet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://play-lh.googleusercontent.com/lWinLRCz-E5CB2NNsJbAT3hzE08e6f6znxSno1u0QKRZ72mWi465CTyMOGhIWqg9twi1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PET>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PET>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

