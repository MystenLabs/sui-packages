module 0xc211ad917dd541a67c830a0a6a1d1fdd18e531e279b4e1a23bebdd45f004c813::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"Fishy fish", b"You sir, are a fish!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b78fc37d0a82a6a6ba5b525e1f2394dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

