module 0x6017b31159043ede55abe0583dd96e793ef8de8aacadc7582f6a4486b9d2a2f6::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 9, b"Frt", b"Fart Coin", b"Everyone does it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5377c5b3b1bc1df980068326c7d31f9bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

